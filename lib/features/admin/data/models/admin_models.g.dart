// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeModelImpl _$$EmployeeModelImplFromJson(Map<String, dynamic> json) =>
    _$EmployeeModelImpl(
      employeeId: (json['employeeId'] as num).toInt(),
      position: json['position'] as String,
      state: json['state'] as String,
      hireDate: json['hireDate'] as String,
      userId: (json['userId'] as num).toInt(),
      userName: json['userName'] as String,
      userEmail: json['userEmail'] as String,
      userDni: json['userDni'] as String,
      userPhone: json['userPhone'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$EmployeeModelImplToJson(_$EmployeeModelImpl instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'position': instance.position,
      'state': instance.state,
      'hireDate': instance.hireDate,
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userDni': instance.userDni,
      'userPhone': instance.userPhone,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_$AdminUserModelImpl _$$AdminUserModelImplFromJson(Map<String, dynamic> json) =>
    _$AdminUserModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      dni: json['dni'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      enabled: json['enabled'] as bool,
      accountLocked: json['accountLocked'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      deletedAt: json['deletedAt'] as String?,
    );

Map<String, dynamic> _$$AdminUserModelImplToJson(
  _$AdminUserModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'dni': instance.dni,
  'email': instance.email,
  'phone': instance.phone,
  'role': instance.role,
  'enabled': instance.enabled,
  'accountLocked': instance.accountLocked,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'deletedAt': instance.deletedAt,
};
