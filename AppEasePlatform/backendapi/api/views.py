from django.shortcuts import render
from rest_framework import viewsets
from django.contrib.auth.models import User
from .serializer import UserSeralizer, HealthDynamicSerializer, HealthStaticSerializer
from .models import healthData
from rest_framework.response import Response
from django.http import HttpResponseNotFound
# from child.models import Child
# from child.serializers import ChildSerializer
# from rest_framework import status
# from rest_framework.views import APIView
# from django.http import Http404
# from rest_framework import mixins
# from rest_framework import generics
# from child.serializers import UserSerializer
# from rest_framework import permissions
# from child.permissions import IsOwnerOrReadOnly
from rest_framework.decorators import api_view
# from rest_framework.reverse import reverse

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSeralizer

@api_view(['GET'])
def healthStaticView(request,userToken):
    try:
        print(healthData._meta.db_table)
        healthStaticData = healthData.objects.filter(usertoken=userToken)
    except healthData.DoesNotExist:
        return HttpResponseNotFound("not a valid token")
    serializer = HealthStaticSerializer(healthStaticData, many = True)
    return Response(serializer.data)

@api_view(['GET'])
def healthDynamicView(request,userToken):
    try:
        print(healthData._meta.db_table)
        healthDynamicData = healthData.objects.filter(usertoken=userToken)
    except healthData.DoesNotExist:
        return HttpResponseNotFound("not a valid token")
    serializer = HealthDynamicSerializer(healthDynamicData, many = True)
    return Response(serializer.data)

# @api_view(['GET'])
# def api_root(request, format=None):
#     return Response({
#         'users': reverse('user-list', request=request, format=format),
#         'child': reverse('child-list', request=request, format=format)
#     })

# class UserList(generics.ListAPIView):
#     queryset = User.objects.all()
#     serializer_class = UserSerializer

# class UserDetail(generics.RetrieveAPIView):
#     queryset = User.objects.all()
#     serializer_class = UserSerializer

# class ChildList(generics.ListCreateAPIView):
#     queryset = Child.objects.all()
#     serializer_class = ChildSerializer
#     permission_classes = [permissions.IsAuthenticatedOrReadOnly]

#     def perform_create(self, serializer):
#         serializer.save(owner=self.request.user)


# class ChildDetail(generics.RetrieveUpdateDestroyAPIView):
#     queryset = Child.objects.all()
#     serializer_class = ChildSerializer
#     permission_classes = [permissions.IsAuthenticatedOrReadOnly, IsOwnerOrReadOnly]
