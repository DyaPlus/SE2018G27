from django.conf.urls import url
from .views import *
from django.urls import path
from rest_framework.authtoken import views

urlpatterns = [
     path('', HMSProfileList.as_view()),
     url(r'^profile/', GetProfile.as_view()),
     url(r'^genreport/', GenerateReport.as_view()),
     url(r'^getreportdetails/(?P<target>[0-9]+)/$', GetReportDetails.as_view()),
     url(r'^getreportpdf/(?P<target>[0-9]+)/(?P<reportid>[0-9]+)/$', GetReportPDF.as_view()),
     url(r'^queryslot/(?P<doctorid>[0-9]+)/$', QuerySlot.as_view()),
     url(r'^reserveslot/$', ReserveSlot.as_view()),
     url(r'^queryres/$', QueryReservations.as_view()),
]

urlpatterns += [
    url(r'^signin/', CustomAuthToken.as_view()),
    url(r'^signup/', SignUp.as_view())
]
