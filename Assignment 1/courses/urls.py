from courses import views
from django.conf.urls import url

urlpatterns = [
    url(r'^$', views.CourseView.as_view()),
    url(r'^(?P<pk>[0-9]+)', views.SpecificCourseView.as_view()),

]

