from django.contrib import admin
from .models import *

class ReceptionistAdmin(admin.ModelAdmin):
    readonly_fields=('password',)

admin.site.register(Receptionist,ReceptionistAdmin)
