from django.conf.urls import url
from .views import *
from django.urls import path
from rest_framework.authtoken import views

urlpatterns = [
     path('', HMSProfileList.as_view()),
     url(r'^lol/', Test.as_view()),
]

urlpatterns += [
    url(r'^signin/', CustomAuthToken.as_view()),
    url(r'^signup/', SignUp.as_view())
]
