from django.shortcuts import render
from rest_framework import viewsets
from .models import TbResponsaveis
from .serializers import SerializerTbResponsaveis 

class ViewSetTbResponsaveis(viewsets.ModelViewSet):
    queryset = TbResponsaveis.objects.all()
    serializer_class = SerializerTbResponsaveis
