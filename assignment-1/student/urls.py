from student import views
from django.conf.urls import url
from django.urls import path

urlpatterns = [
    url(r'^$', views.ProfileView.as_view()),
    url(r'^(?P<pk>[0-9]+)',views.OneProfileView.as_view()),

]



