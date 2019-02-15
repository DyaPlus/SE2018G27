# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.contrib.postgres.fields import ArrayField
from django.db import models
from student.models import Profile



class Course(models.Model):
    id = models.AutoField(primary_key=True)
    Name=models.CharField(max_length=20);
    Max_Grades=models.IntegerField(default=90);
    Study_Years=models.IntegerField(default=1);

    def __str__(self):
        return self.Name



