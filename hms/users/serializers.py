from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from .models import *
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator


class MobileValidator(RegexValidator):
     regex = r'^01[0125]\d{8}'
     message = 'Not a Valid Mobile Number'

class UserSerializer(serializers.ModelSerializer):
	username = serializers.CharField(validators=[UniqueValidator(queryset=User.objects.all(), message="A user with that username already exists")])
	class Meta:
		model = User
		fields=('id','username','password')


class HMSProfileSerializer(serializers.ModelSerializer):
     mobile = serializers.CharField(max_length=11,validators=[MobileValidator(),])
     class Meta:
         model = HMSProfile
         fields=('__all__')
