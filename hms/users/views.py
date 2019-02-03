from rest_framework import generics,status,permissions
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from .models import *
from .serializers import *
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth import authenticate

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

class Test(APIView):
    def get(self, request):
        user = request.user
        serializer = HMSProfileSerializer(user.profile)
        return Response(serializer.data)
