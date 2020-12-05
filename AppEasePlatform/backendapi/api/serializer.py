from rest_framework import serializers
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
# from child.models import Child

class UserSeralizer(serializers.ModelSerializer):
    # child = serializers.HyperlinkedRelatedField(many=True, view_name='child-detail',read_only=True)
    # owner = serializers.ReadOnlyField(source='owner.username')
    
    class Meta:
        model = User
        fields = ['id','username','password']
        extra_kwargs = {'password':{'write_only':True,'required':True}}

    def create(self,validated_data):
        user = User.objects.create_user(**validated_data)
        Token.objects.create(user=user)
        return user

# class ChildSerializer(serializers.HyperlinkedModelSerializer):
#     owner = serializers.ReadOnlyField(source='owner.username')
#     class Meta:
#         model = Child
#         fields = ['id', 'name', 'age']

#     def create(self, validated_data):
#         return Child.objects.create(**validated_data)

#     def update(self, instance, validated_data):
#         instance.name = validated_data.get('name', instance.title)
#         instance.content = validated_data.get('age', instance.content)
#         instance.save()
#         return instance