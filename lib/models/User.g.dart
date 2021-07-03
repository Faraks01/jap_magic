// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    username: json['username'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String,
    hasVerifiedEmail: json['has_verified_email'] as bool,
    hasVerifiedPhone: json['has_verified_phone'] as bool,
    isActive: json['is_active'] as bool,
    phone: json['phone'] as String,
  )..name = json['name'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'has_verified_email': instance.hasVerifiedEmail,
      'has_verified_phone': instance.hasVerifiedPhone,
      'is_active': instance.isActive,
      'phone': instance.phone,
    };
