from django.db import models
from django.contrib.auth.models import User

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
    provider=models.ForeignKey(Pharmacy, on_delete=models.CASCADE,null=True)
    quantity=models.IntegerField(null=True)
    def __str__(self):
        return self.title + ' ' + str(self.provider)
