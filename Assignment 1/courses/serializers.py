from rest_framework import serializers
from .models import Course
from student.serializers import ProfileSerializer



class CourseSerializer(serializers.ModelSerializer):
    class Meta:
      model=Course
      fields='__all__'