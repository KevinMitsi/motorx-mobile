// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      dni: json['dni'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      phone: json['phone'] as String,
      createdAt: json['createdAt'] as String,
      role: json['role'] as String,
      employeePosition: json['employeePosition'] as String?,
      employeeId: (json['employeeId'] as num?)?.toInt(),
      enabled: json['enabled'] as bool,
      accountLocked: json['accountLocked'] as bool,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dni': instance.dni,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'createdAt': instance.createdAt,
      'role': instance.role,
      'employeePosition': instance.employeePosition,
      'employeeId': instance.employeeId,
      'enabled': instance.enabled,
      'accountLocked': instance.accountLocked,
      'updatedAt': instance.updatedAt,
    };
