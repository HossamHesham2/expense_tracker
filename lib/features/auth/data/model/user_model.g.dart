// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  uid: json['uid'] as String,
  fullName: json['fullName'] as String?,
  email: json['email'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'uid': instance.uid,
  'fullName': instance.fullName,
  'email': instance.email,
  'createdAt': instance.createdAt,
};
