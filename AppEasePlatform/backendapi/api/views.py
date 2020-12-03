from django.shortcuts import render
from rest_framework import viewsets
from django.contrib.auth.models import User
from .serializer import UserSeralizer
# from rest_framework.response import Response
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
# from rest_framework.decorators import api_view
# from rest_framework.reverse import reverse

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSeralizer

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
