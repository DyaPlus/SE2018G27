from rest_framework import generics
from .models import *
from .serializers import *

class PatientList(generics.ListCreateAPIView):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer
