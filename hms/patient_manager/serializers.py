from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from .models import *
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator


class MobileValidator(RegexValidator):
     regex = r'^01[0125]\d{8}'
     message = 'Not a Valid Mobile Number'

class PatientSerializer(serializers.ModelSerializer):
    password = serializers.CharField(max_length=30,write_only=True)
    mobile = serializers.CharField(max_length=11,validators=[MobileValidator(),])

    class Meta:
        model = Patient
        fields=('__all__')
    def create(self, validated_data):
        print(validated_data)
        return Patient.objects.create(**validated_data)
