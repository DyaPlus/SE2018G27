from grades import views
from django.conf.urls import url

urlpatterns = [
    url(r'^$', views.GradesView.as_view()),
    url(r'^(?P<pk>[0-9]+)',views.OneGradeView.as_view()),

]



