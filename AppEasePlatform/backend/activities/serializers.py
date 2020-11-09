from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Info, AnxietyData, Records

class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user
    class Meta:
        model = User
        fields = ('id', 'username', 'password')
        extra_kwargs = {
            'password': {'write_only': True}
        }

class InfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Info
        fields = '__all__'

class RecordsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Records
        fields = '__all__'

class AnxietyDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = AnxietyData
        fields = '__all__'