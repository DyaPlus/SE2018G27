# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from __future__ import unicode_literals
from rest_framework.views import APIView
from .models import Grade
from .serializers import GradesSerializer
from rest_framework.response import Response
from rest_framework import status
from student.models import Profile
from student.serializers import ProfileSerializer
from courses.models import Course
from courses.serializers import CourseSerializer


from django.shortcuts import render

# Create your views here.
class GradesView(APIView):
    def get(self,request):
        grades = Grade.objects.all()
        serializer = GradesSerializer(grades, many=True)
        return Response(serializer.data)

    def post(self,request):
        print(request.data)
        serializer = GradesSerializer(data=request.data)
        #there is no Error checking b2a :'D
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def get_student(self,pk):
        print(pk)
        student = Profile.objects.get(id=pk)
        return student


    def get_course(self,pk):
        course = Course.objects.get(id=pk)
        return course

class OneGradeView(APIView):

    def put(self,request,pk):
        grade=Grade.objects.get(id=pk)
        serializer = GradesSerializer(grade,data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self,request,pk):
        grade=Grade.objects.get(id=pk)
        grade.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
