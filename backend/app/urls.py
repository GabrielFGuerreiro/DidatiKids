from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ViewSetTbResponsaveis

router = DefaultRouter()
router.register(r'TbResponsaveis', ViewSetTbResponsaveis)

urlpatterns = [
    path('', include(router.urls)),
]