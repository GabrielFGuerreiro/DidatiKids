from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from .views import (
    CadastroResponsavelView,
    PerfisCriancasView,
    CadastroCriancaView,
    AtividadesPorCriancaView,
    ListaTopicosView,
    AtualizaStatusAtividadeView
)

urlpatterns = [
    path('cadastrar/', CadastroResponsavelView.as_view(), name='cadastrar'),
    path('login/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('responsavel/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('home/', PerfisCriancasView.as_view(), name='home'),
    path('crianca/', CadastroCriancaView.as_view(), name='crianca'),
    path('criancas/<int:id_crianca>/atividades/', AtividadesPorCriancaView.as_view(), name='atividades'),
    path('topicos/', ListaTopicosView.as_view(), name='lista_topicos'),
    path('criancas/<int:id_crianca>/atividades/<int:id_atividade>/concluir/', AtualizaStatusAtividadeView.as_view(), name='atualiza_status_atividade'),

]
