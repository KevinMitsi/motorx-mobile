// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseModelImpl _$$AuthResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AuthResponseModelImpl(
  token: json['token'] as String,
  type: json['type'] as String,
  userId: (json['userId'] as num).toInt(),
  email: json['email'] as String,
  name: json['name'] as String,
  role: json['role'] as String,
  employeePosition: json['employeePosition'] as String?,
  employeeId: (json['employeeId'] as num?)?.toInt(),
);

Map<String, dynamic> _$$AuthResponseModelImplToJson(
  _$AuthResponseModelImpl instance,
) => <String, dynamic>{
  'token': instance.token,
  'type': instance.type,
  'userId': instance.userId,
  'email': instance.email,
  'name': instance.name,
  'role': instance.role,
  'employeePosition': instance.employeePosition,
  'employeeId': instance.employeeId,
};
