from requests import Response
from rest_framework import serializers
from .models import TbResponsaveis, TbAtividades, TbCriancas, TbFaixasetarias, TbCriancaTopicos, TbTopicos, TbCriancaAtividades
from django.contrib.auth.hashers import make_password
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth.models import User
from datetime import date, datetime

class ResponsavelSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = TbResponsaveis
        fields = ['nome', 'email', 'dt_nascimento', 'senha']
        extra_kwargs = {
            'senha': {'write_only': True}
        }


    def create(self, validated_data):
        pwd = validated_data['senha']
        validated_data['senha'] = make_password(pwd)
        responsavel = super().create(validated_data)

        User.objects.update_or_create(
            username=responsavel.email,
            defaults={
                'password': make_password(pwd),
                'first_name': responsavel.nome or '',
                'is_active': True
            }
        )

        return responsavel

class CriancaSerializer(serializers.ModelSerializer):
    class Meta:
        model = TbCriancas
        fields = '__all__'

class CadastroCriancaSerializer(serializers.ModelSerializer):
    """
    Classe utilizada para o cadastro do perfil da criança.
    """

    topicos_interesse = serializers.ListField(
        child=serializers.IntegerField(), write_only=True
    )

    class Meta:
        model = TbCriancas
        fields = ['nome', 'dt_nascimento', 'topicos_interesse']

    def validate(self, data):
        user = self.context['responsavel']
        responsavel = TbResponsaveis.objects.get(email=user.username) if isinstance(user, User) else user

        if TbCriancas.objects.filter(id_responsavel=responsavel).count() >= 6:
            raise serializers.ValidationError("Você já atingiu o limite de 6 perfis de criança.")
        
        return data
    
    def create(self, validated_data):

        topicos_ids = validated_data.pop('topicos_interesse', [])
        
        nasc = validated_data['dt_nascimento'].year
        hoje = date.today().year
        idade = hoje - nasc

        if idade >= 6 and idade < 7:
            faixa_etaria = TbFaixasetarias.objects.get(pk=1)
        elif idade < 8:
            faixa_etaria = TbFaixasetarias.objects.get(pk=2)
        elif idade <= 9:
            faixa_etaria = TbFaixasetarias.objects.get(pk=3)
        else:
            faixa_etaria = None

        user = self.context['responsavel']
        if isinstance(user, User):
            responsavel = TbResponsaveis.objects.get(email=user.username)
        else:
            responsavel = user

        crianca = TbCriancas.objects.create(
            id_responsavel=responsavel,
            id_faixa_etaria=faixa_etaria,
            **validated_data
        )

        for topico_id in topicos_ids:
            TbCriancaTopicos.objects.create(
                id_crianca=crianca,
                id_topico=TbTopicos.objects.get(pk=topico_id)
            )

        atividades = TbAtividades.objects.filter(
        id_faixa_etaria=faixa_etaria,
        id_topico__in=topicos_ids
        )

        for atividade in atividades:
            TbCriancaAtividades.objects.create(
                id_crianca=crianca,
                id_atividade=atividade,
                concluida=False
            )

        return crianca

class TopicoSerializer(serializers.ModelSerializer):
    class Meta:
        model = TbTopicos
        fields = '__all__'

class AtividadeSerializer(serializers.ModelSerializer):
    class Meta:
        model = TbAtividades
        fields = '__all__'

class AtividadeComStatusSerializer(serializers.ModelSerializer):
    concluida = serializers.SerializerMethodField()

    class Meta:
        model = TbAtividades
        fields = ['id_atividade', 'descricao', 'concluida']

    def get_concluida(self, atividade):
        crianca = self.context.get('crianca')
        try:
            relacao = TbCriancaAtividades.objects.get(id_crianca=crianca, id_atividade=atividade)
            return relacao.concluida
        except TbCriancaAtividades.DoesNotExist:
            return False

class CustomTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        token['nome'] = user.nome
        token['id_responsavel'] = user.id_responsavel
        return token
