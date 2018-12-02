from django.conf.urls import url
from .views import *
from django.urls import path

urlpatterns = [
     path('', DoctorList.as_view()),
]
