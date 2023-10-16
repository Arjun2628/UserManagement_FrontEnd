// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      age: json['age'] as int?,
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'email': instance.email,
      'profileImage': instance.profileImage,
      '__v': instance.v,
    };
