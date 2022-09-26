// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      userId: json['userId'] as String?,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profilePicUrl: json['profilePicUrl'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      phoneVerifiedAt: json['phoneVerifiedAt'] as String? ?? "",
      deviceToken: json['deviceToken'] as String?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'profilePicUrl': instance.profilePicUrl,
      'phone': instance.phone,
      'phoneVerifiedAt': instance.phoneVerifiedAt,
      'deviceToken': instance.deviceToken,
    };
