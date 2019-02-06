from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

USER_TYPE=(
('P','Patient'),
('D','Doctor'),
('R','Receptionist'),
)

REPORT_TYPE=(
('A','Analysis'),
('R','Rays'),
('E','Examination'),
)


class HMSProfile(models.Model):
    user=models.OneToOneField(User, on_delete=models.CASCADE,related_name="profile",null=True)
    full_name=models.CharField(max_length=30,unique=True)
    national_id=models.CharField(unique=True,max_length=16)
    mobile=models.CharField(max_length=11,blank=True)
    type=models.CharField(max_length=16,choices=USER_TYPE,default='P')
    def __str__(self):
        return self.full_name

class Report(models.Model):
    title=models.CharField(max_length=30,choices=REPORT_TYPE,default='E')
    target=models.ForeignKey(User, on_delete=models.CASCADE,null=True)
    content=models.TextField(null=True)
    created_at = models.DateTimeField(auto_now_add=True, null=True)

    def __str__(self):
        switcher = {
        'E':'Examination Result',
        'R':'Rays Result',
        'A':'Analysis Result',
        }
        return self.target.username + ' ' + switcher.get(self.title) + ' ' + str(self.created_at.day) + '/' + str(self.created_at.month) + '/' + str(self.created_at.year) + ' ' + str(self.created_at.hour) + ':' + str(self.created_at.minute)

class Pharmacy(models.Model):
    title=models.CharField(max_length=30,null=True)
    def __str__(self):
        return self.title

class Medicine(models.Model):
    title=models.CharField(max_length=30,null=True)
    provider=models.ForeignKey(Pharmacy, on_delete=models.CASCADE,null=True,related_name='medicines')
    quantity=models.IntegerField(null=True)
    def __str__(self):
        return self.title + ' - ' + str(self.provider)

class Slot(models.Model):
    time=models.DateTimeField()
    max_no=models.IntegerField()
    available_no=models.IntegerField(default=0)
    is_open=models.BooleanField(default=False)
    doctor=models.ForeignKey(HMSProfile,on_delete=models.CASCADE,related_name='slots')

    class Meta:
        default_permissions = ('add', 'change', 'delete', 'view')

    def __str__(self):
        date = timezone.localtime(self.time)
        str_format = date.strftime("%A %d-%m %I:%M %p")
        return str_format 

class Reservation(models.Model):
    slot=models.ForeignKey(Slot,on_delete=models.CASCADE)
    doctor=models.ForeignKey(HMSProfile,on_delete=models.CASCADE,related_name='timetable')
    patient=models.ForeignKey(HMSProfile,on_delete=models.CASCADE,related_name='reservations')
    def __str__(self):
        date = timezone.localtime(self.slot.time)
        str_format = date.strftime("%A %d-%m %I:%M %p")
        return str(self.patient) + ' reservation with ' + str(self.doctor) + ' on ' + str_format
