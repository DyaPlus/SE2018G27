# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
from student.models import Profile
from courses.models import Course


class Grade(models.Model):
    id = models.AutoField(primary_key=True)
    grade = models.CharField(max_length=20);
    student=models.ForeignKey(
        Profile, on_delete=models.CASCADE)
    course=models.ForeignKey(
        Course, on_delete=models.CASCADE)


