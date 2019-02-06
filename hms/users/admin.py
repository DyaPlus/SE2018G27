from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import *

class ReportAdmin(admin.ModelAdmin):
    readonly_fields = ('created_at',)

admin.site.register(HMSProfile)
admin.site.register(Report,ReportAdmin)
admin.site.register(Medicine)
admin.site.register(Pharmacy)
