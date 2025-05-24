from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework import status
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth.hashers import check_password
from django.contrib.auth import authenticate
from .models import TbCriancas, TbResponsaveis, TbAtividades, TbTopicos, TbCriancaAtividades, TbCriancaTopicos
from .serializers import (
    ResponsavelSerializer, CriancaSerializer, CadastroCriancaSerializer, AtividadeSerializer, CustomTokenObtainPairSerializer, TopicoSerializer, AtividadeComStatusSerializer
)
from rest_framework.generics import ListAPIView

class CustomTokenObtainPairView(TokenObtainPairView):
    """
    Classe para realizar a autenticação com o JSON Web Token (JWT).
    """
    serializer_class = CustomTokenObtainPairSerializer

class CadastroResponsavelView(APIView):
    """
    Classe utilizada para realizar o cadastro do responsável.
    Realiza um POST para o envio dos dados.
    """
    queryset = TbResponsaveis.objects.all()
    serializer_class = ResponsavelSerializer
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = ResponsavelSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        responsavel = serializer.save()
        return Response(ResponsavelSerializer(responsavel).data, status=status.HTTP_201_CREATED)

class LoginResponsavelView(APIView):
    """
    Classe utilizada para o login do responsável. Gera um token de autenticação que será utilizado durante todo o período de conexão.
    Realiza um POST para o envio dos dados.
    """
    permission_classes = [AllowAny]

    def post(self, request):
        email = request.data.get("email")
        senha = request.data.get("senha")
        try:
            
            user = authenticate(username=email, password=senha)
            if user is not None:
                # Buscar dados do TbResponsaveis correspondente
                try:
                    responsavel = TbResponsaveis.objects.get(email=user.email)
                except TbResponsaveis.DoesNotExist:
                    return Response({"erro": "Cadastro não encontrado."}, status=404)

                refresh = RefreshToken.for_user(user)
                return Response({
                    "id_responsavel": responsavel.id_responsavel,
                    "nome": responsavel.nome,
                    "access": str(refresh.access_token),
                    "refresh": str(refresh),
                })

            return Response({"erro": "Email ou senha inválidos."}, status=401)
        
        except TbResponsaveis.DoesNotExist:
            return Response({"erro": "Cadastro não encontrado."}, status=404)

class PerfisCriancasView(APIView):
    """
    Classe utilizada para listar os perfis de crianças no cadastro do responsável.
    """

    permission_classes = [IsAuthenticated]

    def get(self, request):
        email = request.user.username
        responsavel = TbResponsaveis.objects.get(email=email)
        criancas = TbCriancas.objects.filter(id_responsavel=responsavel.id_responsavel)
        serializer = CriancaSerializer(criancas, many=True)
        return Response(serializer.data)

class ListaTopicosView(ListAPIView):
    """
    Classe utilizada para listar os tópicos de interesse registrados na base de dados.
    """
    permission_classes = [IsAuthenticated]

    def get(self, request):
        topicos = TbTopicos.objects.all()
        serializer = TopicoSerializer(topicos, many=True)

        return Response(serializer.data)


class CadastroCriancaView(APIView):
    """
    Classe utilizada para criar um perfil de criança.
    """
    permission_classes = [IsAuthenticated]

    def post(self, request):
        email = request.user.username
        responsavel = TbResponsaveis.objects.get(email=email)
        
        serializer = CadastroCriancaSerializer(data=request.data, context={'responsavel': responsavel})
        serializer.is_valid(raise_exception=True)
        crianca = serializer.save()
        return Response(CriancaSerializer(crianca).data, status=status.HTTP_201_CREATED)

class AtividadesPorCriancaView(APIView):
    """
    Classe utilizada para listar as atividades que serão disponibilizadas no perfil da criança.
    """
    permission_classes = [IsAuthenticated]

    def get(self, request, id_crianca):
        try:
            crianca = TbCriancas.objects.get(id_crianca=id_crianca)
        except TbCriancas.DoesNotExist:
            return Response({'erro': 'Perfil não encontrado.'}, status=404)

        atividades = TbAtividades.objects.filter(id_faixa_etaria=crianca.id_faixa_etaria)

        if crianca.id_dificuldade:
            atividades = atividades.filter(id_dificuldade=crianca.id_dificuldade)

        topicos_ids = TbCriancaTopicos.objects.filter(id_crianca=crianca).values_list('id_topico', flat=True)

        atividades = TbAtividades.objects.filter(
                id_faixa_etaria=crianca.id_faixa_etaria,
                id_topico__in=topicos_ids
            ).distinct()

        serializer = AtividadeComStatusSerializer(atividades, many=True, context={'crianca': crianca})

        return Response(serializer.data)


class AtualizaStatusAtividadeView(APIView):
    """
    Classe utilizada para atualizar o status da atividade no perfil da criança.
    """
    permission_classes = [IsAuthenticated]

    def post(self, request, id_crianca, id_atividade):
        try:
            crianca_atividade = TbCriancaAtividades.objects.get(
                id_crianca_id=id_crianca,
                id_atividade_id=id_atividade
            )
        except TbCriancaAtividades.DoesNotExist:
            return Response({"erro": "Atividade não encontrada para esta criança."}, status=404)

        concluida = request.data.get('concluida')
        if concluida is None:
            return Response({"erro": "Campo 'concluida' obrigatório."}, status=400)

        crianca_atividade.concluida = bool(concluida)
        crianca_atividade.save()

        return Response({"status": "Atualizado com sucesso."})
    
