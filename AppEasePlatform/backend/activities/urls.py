from django.urls import path
from .views import LoginAPI, ChangePasswordView, RegisterAPI, ChildDetailView, ChildListView, ChildCreateView
from knox import views as knox_views
from . import views

urlpatterns = [
    path('api/register/', RegisterAPI.as_view(), name='register'),
    path('api/login/', LoginAPI.as_view(), name='login'),
    path('api/logout/', knox_views.LogoutView.as_view(), name='logout'),
    path('api/change-password/', ChangePasswordView.as_view(), name='change-password'),
    path('api/child-list/', ChildListView.as_view(), name='child-list'),
    path('api/child-detail/<pk>/', ChildDetailView.as_view(), name='child-detail'),
    path('api/child-create/', ChildCreateView.as_view(), name='child-create'),
]