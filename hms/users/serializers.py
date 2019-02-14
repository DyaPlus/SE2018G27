from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from .models import *
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator
from django.utils import timezone


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

class ReportSerializer(serializers.ModelSerializer):
     class Meta:
         model = Report
         fields=('__all__')

class MedicineSerializer(serializers.ModelSerializer):
     class Meta:
         model = Medicine
         fields=('__all__')

class SlotSerializer(serializers.ModelSerializer):
    time = serializers.DateTimeField(format='%A %d-%m %I:%M %p')
    class Meta:
        model = Slot
        fields = ('id','time')

class ReservationSerializer(serializers.ModelSerializer):
    slot=serializers.SerializerMethodField()
    doctor=serializers.SerializerMethodField()
    patient=serializers.SerializerMethodField()
    class Meta:
         model = Reservation
         fields=('__all__')
    def get_slot(self,obj):
        return str(obj.slot)
    def get_doctor(self,obj):
        return obj.doctor.full_name
    def get_patient(self,obj):
        return obj.patient.full_name
