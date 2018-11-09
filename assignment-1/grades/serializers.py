from rest_framework import serializers
from .models import Grade
from courses.serializers import CourseSerializer
from student.serializers import ProfileSerializer



class GradesSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    firstname = serializers.SerializerMethodField()
    lastName = serializers.SerializerMethodField()

    class Meta:
      model=Grade
      fields=('id','grade','student','course','name','firstname','lastName')

    def get_name(self,model):
    	return model.course.Name

    def get_firstname(self,model):
    	return model.student.firstname

    def get_lastName(self,model):
    	return model.student.lastName

   