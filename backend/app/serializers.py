from rest_framework import serializers
from .models import TbResponsaveis

class SerializerTbResponsaveis(serializers.ModelSerializer):
    class Meta:
        model = TbResponsaveis
        fields = '__all__'
        