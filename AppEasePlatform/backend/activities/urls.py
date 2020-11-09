from django.urls import path
from . import views

urlpatterns = [
    path('child-create/', views.create_child, name = 'create-child'),
    path('child-detail/<pk>/', views.list_child, name = 'list-child'),
    path('child-update/<pk>', views.update_child, name='update-child'),
    path('register/', views.register),
    path('token/', views.token),
    path('token/refresh/', views.refresh_token),
    path('token/revoke/', views.revoke_token),
]