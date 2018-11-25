from django.contrib import admin
from .models import *

class PatientAdmin(admin.ModelAdmin):
    readonly_fields=('password',)

admin.site.register(Patient,PatientAdmin)
