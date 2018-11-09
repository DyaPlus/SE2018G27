# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from rest_framework.views import APIView
from .models import Profile
from .serializers import ProfileSerializer
from rest_framework.response import Response
from rest_framework import status


# Create your views here.
class ProfileView(APIView):

    def get(self,request):
        students = Profile.objects.all()
        serializer = ProfileSerializer(students, many=True)
        return Response(serializer.data)


    def post(self,request):
        serializer = ProfileSerializer(data=request.data)
        #there is no Error checking b2a :'D
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def get_specific_student(self,pk):
        student=Profile.objects.get(id=pk)
        return  student

    def delete(self,request):
        serializer = ProfileSerializer(data=request.data)
        pk=serializer.validated_data['id']
        badstudnet=self.get_specific_student(pk)
        badstudnet.delete()
        return Response ({'message':"deleted"},status=status.HTTP_201_CREATED)


class OneProfileView(APIView):

    def get(self,request,pk):
        student=Profile.objects.get(id=pk)
        serializer = ProfileSerializer(student)
        return Response(serializer.data)


    def put(self,request,pk):
    	student=Profile.objects.get(id=pk)
    	serializer = ProfileSerializer(student,data=request.data)
    	if serializer.is_valid():
    		serializer.save()
    		return Response(serializer.data)
    	return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self,request,pk):
   		student=Profile.objects.get(id=pk)
   		student.delete()
   		return Response(status=status.HTTP_204_NO_CONTENT)










