from django.contrib import admin
from django.urls import path
from django.conf.urls import include
from rest_framework import routers
from .views import UserViewSet
# from child import views


router = routers.DefaultRouter()
router.register('users',UserViewSet)

urlpatterns = [
    path('',include(router.urls)),
#     path('child/',
#          views.ChildList.as_view(),
#          name='child-list'),
#     path('child/<int:pk>/',
#          views.ChildDetail.as_view(),
#          name='child-detail'),
#     path('users/',
#          views.UserList.as_view(),
#          name='user-list'),
#     path('users/<int:pk>/',
#          views.UserDetail.as_view(),
#          name='user-detail')
]
