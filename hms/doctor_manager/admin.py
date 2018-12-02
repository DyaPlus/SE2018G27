from django.contrib import admin
from .models import *

class DoctorAdmin(admin.ModelAdmin):
    readonly_fields=('password',)

admin.site.register(Doctor,DoctorAdmin)
