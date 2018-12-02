from rest_framework import generics
from .models import *
from .serializers import *

class ReceptionistList(generics.ListCreateAPIView):
    queryset = Receptionist.objects.all()
    serializer_class = ReceptionistSerializer
