from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import *

class ReportAdmin(admin.ModelAdmin):
    readonly_fields = ('created_at',)

class ReservationAdmin(admin.ModelAdmin):
    search_fields=('patient__full_name','doctor__full_name')

class PharmacyAdmin(admin.ModelAdmin):
    search_fields=('title',)

class MedicineAdmin(admin.ModelAdmin):
    search_fields=('title',)

class HMSProfileAdmin(admin.ModelAdmin):
    search_fields=('full_name',)
class SlotAdmin(admin.ModelAdmin):
    list_display = ['time','doctor', 'is_open','max_no','available_no']
    search_fields=('doctor__full_name','time')

admin.site.register(HMSProfile,HMSProfileAdmin)
admin.site.register(Report,ReportAdmin)
admin.site.register(Medicine,MedicineAdmin)
admin.site.register(Pharmacy,PharmacyAdmin)
admin.site.register(Slot,SlotAdmin)
admin.site.register(Reservation,ReservationAdmin)
