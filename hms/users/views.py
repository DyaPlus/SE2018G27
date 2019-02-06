from rest_framework import generics,status,permissions
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from .models import *
from .serializers import *
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth import authenticate
import io
from django.http import FileResponse,HttpResponse
import pdfkit
from .templates import *
from django.template import Context, Template
import datetime
from django.core.exceptions import ObjectDoesNotExist

def genPDF(target,title,content):
    switcher = {
    'E':'Examination Result',
    'R':'Rays Result',
    'A':'Analysis Result',
    }
    options = {
        'page-size': 'A4',
        'margin-top': '0.75in',
        'margin-right': '0.75in',
        'margin-bottom': '0.75in',
        'margin-left': '0.75in',
        'encoding': "UTF-8",
    }
    now = datetime.datetime.now()
    patient = User.objects.get(id=target)
    t = Template(report_temp)
    string = t.render(Context({'title':switcher.get(title),'date':(str(now.day)+'/'+str(now.month)
    +' '+str(now.hour)+':'+str(now.minute)),
    'content':content,'target':patient.username}))
    return pdfkit.from_string(string, False, options=options)
#Sign in View
class CustomAuthToken(ObtainAuthToken):
    permission_classes = (permissions.AllowAny,)

    def post(self, request, *args, **kwargs):
        try:
            user = authenticate(username=request.data['username'],password=request.data['password'])
        except IntegrityError as e:
            return Response({'boom' : 'lool'})
        if user is not None:
            token, created = Token.objects.get_or_create(user=user)
            serializer = HMSProfileSerializer(user.profile)
            return Response({
                'token': token.key,
                'user_type' : serializer.data['type']
                })
        return Response({"valid": False,'error' : 'Wrong Credentials'}, status=status.HTTP_400_BAD_REQUEST)
#SIgn Up View
class SignUp(ObtainAuthToken):
    permission_classes = (permissions.AllowAny,)

    def post(self, request, format=None):
        username = request.data.get('username')
        password = request.data.get('password')
        password2 = request.data.get('password2')
        full_name = request.data.get('full_name')
        type = request.data.get('type')
        national_id = request.data.get('national_id')
        mobile = request.data.get('mobile')
        if not password == password2:
            return Response({"valid": False, "error": "Passwords don't match"}, status=status.HTTP_400_BAD_REQUEST)
        serializer = UserSerializer(data=request.data)
        if (serializer.is_valid()):
            print(serializer.data)
            user = User.objects.create_user(username=username,password=password)
            profileserializer = HMSProfileSerializer(data={
            'user' : user.id,
            'full_name' : full_name,
            'type' : type,
            'national_id' : national_id,
            'mobile' : mobile
            })
            if profileserializer.is_valid():
                profileserializer.save()
                user.save()
                token, created = Token.objects.get_or_create(user=user)
                return Response({
                    'token': token.key,
                    'user_type' : profileserializer.data['type']
                    })
            else:
                user.delete()
                return Response({"valid":False, "errors":profileserializer.errors}, status=status.HTTP_400_BAD_REQUEST)
			# user = User.objects.create_user(username=serializer.data['username'], password=serializer.data['password'])
			# user.save()
			# jwt_payload_handler = api_settings.JWT_PAYLOAD_HANDLER
			# jwt_encode_handler = api_settings.JWT_ENCODE_HANDLER
			# payload = jwt_payload_handler(user)
			# token = jwt_encode_handler(payload)
			# return Response({"valid":True, "token":token})
        return Response({"valid":False, "errors":serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

class HMSProfileList(generics.ListCreateAPIView):
    queryset = HMSProfile.objects.all()
    serializer_class = HMSProfileSerializer

#Profile View
class GetProfile(APIView):
    def get(self, request):
        user = request.user
        serializer = HMSProfileSerializer(user.profile)
        return Response(serializer.data)
#Generate REPORT
class GenerateReport(APIView):
    def post(self,request):
        user = request.user
        print(user.profile.type)
        if user.profile.type == 'D':
            serializer = ReportSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
                switcher = {
                'E':'Examination Result',
                'R':'Rays Result',
                'A':'Analysis Result',
                }
                options = {
                    'page-size': 'A4',
                    'margin-top': '0.75in',
                    'margin-right': '0.75in',
                    'margin-bottom': '0.75in',
                    'margin-left': '0.75in',
                    'encoding': "UTF-8",
                }
                now = datetime.datetime.now()
                patient = User.objects.get(id=serializer.data['target'])
                t = Template(report_temp)
                string = t.render(Context({'title':switcher.get(serializer.data['title']),'date':(str(now.day)+'/'+str(now.month)
                +' '+str(now.hour)+':'+str(now.minute)),
                'content':serializer.data['content'],'target':patient.username}))
                pdf = pdfkit.from_string(string, False, options=options)
                response = HttpResponse(content_type='application/pdf')
                filename = 'somefilename.pdf'
                response['Content-Disposition'] = 'attachment; filename="{}"'.format(filename)
                response.write(pdf)
                return response
            return Response({"valid":False, "errors":serializer.errors},status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({"valid":False, "errors":"Only Doctors can generate reports"},status=status.HTTP_400_BAD_REQUEST)

class GetReportDetails(APIView):
    def get(self,request,target):
        user = request.user
        if user.profile.type == 'P':
            try:
                reports = Report.objects.filter(target=user.id)
            except ObjectDoesNotExist as e:
                return Response({"valid":False, "errors":str(e)},status=status.HTTP_400_BAD_REQUEST)
            serializer = ReportSerializer(reports,many=True)
            return Response(serializer.data)
        else:
            try:
                reports = Report.objects.filter(target=target)
            except ObjectDoesNotExist as e:
                return Response({"valid":False, "errors":str(e)},status=status.HTTP_400_BAD_REQUEST)
            serializer = ReportSerializer(reports,many=True)
            return Response(serializer.data)
        return Response({"valid":False, "errors":serializer.errors},status=status.HTTP_400_BAD_REQUEST)

class GetReportPDF(APIView):
    def get(self,request,target,reportid):
        user = request.user
        if user.profile.type == 'P':
            try:
                report = Report.objects.get(target=user.id,id=reportid)
            except ObjectDoesNotExist as e:
                return Response({"valid":False, "errors":str(e)},status=status.HTTP_400_BAD_REQUEST)
            serializer = ReportSerializer(report)
            pdf = genPDF(serializer.data['target'],serializer.data['title'],serializer.data['content'])
            response = HttpResponse(content_type='application/pdf')
            filename = 'somefilename.pdf'
            response['Content-Disposition'] = 'attachment; filename="{}"'.format(filename)
            response.write(pdf)
            return response
        else:
            try:
                report = Report.objects.get(target=target,id=reportid)
            except ObjectDoesNotExist as e:
                return Response({"valid":False, "errors":str(e)},status=status.HTTP_400_BAD_REQUEST)
            serializer = ReportSerializer(report)
            pdf = genPDF(serializer.data['target'],serializer.data['title'],serializer.data['content'])
            response = HttpResponse(content_type='application/pdf')
            filename = 'somefilename.pdf'
            response['Content-Disposition'] = 'attachment; filename="{}"'.format(filename)
            response.write(pdf)
            return response
        return Response({"valid":False, "errors":serializer.errors},status=status.HTTP_400_BAD_REQUEST)