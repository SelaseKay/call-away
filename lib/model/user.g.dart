// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String? ?? "",
      phoneVerifiedAt: json['phoneVerifiedAt'] as String? ?? "",
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'phoneVerifiedAt': instance.phoneVerifiedAt,
    };
