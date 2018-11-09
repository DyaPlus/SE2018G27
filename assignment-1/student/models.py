# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.db import models

class Profile(models.Model):
    id = models.AutoField(primary_key=True)
    firstname=models.CharField(max_length=20);
    lastName = models.CharField(max_length=20);
    year = models.CharField(max_length=1, blank=True, null=True);

    def __str__(self):
        return self.firstname+' '+self.lastName + ' ' + str(self.id)
