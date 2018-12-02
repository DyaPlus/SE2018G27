from rest_framework import generics
from .models import *
from .serializers import *

class DoctorList(generics.ListCreateAPIView):
    queryset = Doctor.objects.all()
    serializer_class = DoctorSerializer
