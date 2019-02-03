from django.db import models
from django.contrib.auth.models import User

USER_TYPE=(
('P','Patient'),
('D','Doctor'),
('R','Receptionist'),
)

class HMSProfile(models.Model):
    user=models.OneToOneField(User, on_delete=models.CASCADE,related_name="profile",null=True)
    full_name=models.CharField(max_length=30,unique=True)
    national_id=models.CharField(unique=True,max_length=16)
    mobile=models.CharField(max_length=11,blank=True)
    type=models.CharField(max_length=16,choices=USER_TYPE,default='P')
    def __str__(self):
        return self.full_name
