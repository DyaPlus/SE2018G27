from django.db import models
from django.contrib.auth.hashers import make_password

class Doctor(models.Model):
    full_name=models.CharField(max_length=30,unique=True)
    national_id=models.CharField(unique=True,max_length=16)
    password=models.CharField(max_length=30)
    mobile=models.CharField(max_length=11,blank=True)

    def save(self, **kwargs):
        self.password = make_password(self.password)
        super(Doctor, self).save()

    class Meta:
        default_permissions = ('add', 'change', 'delete', 'view')

    def __str__(self):
        return self.full_name
