# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from __future__ import unicode_literals
from rest_framework.views import APIView
from .models import Course
from student.models import Profile
from .serializers import CourseSerializer
from rest_framework.response import Response
from rest_framework import status

from django.shortcuts import render

class CourseView(APIView):

    def get(self,request):
        courses=Course.objects.all()
        serializer = CourseSerializer(courses, many=True)
        return Response(serializer.data)

    def post (self,request):
        serializer = CourseSerializer(data=request.data)
        #there is no Error checking b2a :'D
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class SpecificCourseView(APIView):

    def put(self,request,pk):
        course=Course.objects.get(id=pk)
        serializer = CourseSerializer(course,data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
    
    def delete(self,request,pk):
        course=Course.objects.get(id=pk)
        course.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)














