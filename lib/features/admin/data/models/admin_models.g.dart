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

_$PerformanceMetricsModelImpl _$$PerformanceMetricsModelImplFromJson(
  Map<String, dynamic> json,
) => _$PerformanceMetricsModelImpl(
  endpoint: json['endpoint'] as String,
  avgResponseTimeMs: (json['avgResponseTimeMs'] as num).toInt(),
  totalRequests: (json['totalRequests'] as num).toInt(),
  requestsUnderThreshold: (json['requestsUnderThreshold'] as num).toInt(),
  compliancePercent: (json['compliancePercent'] as num).toDouble(),
);

Map<String, dynamic> _$$PerformanceMetricsModelImplToJson(
  _$PerformanceMetricsModelImpl instance,
) => <String, dynamic>{
  'endpoint': instance.endpoint,
  'avgResponseTimeMs': instance.avgResponseTimeMs,
  'totalRequests': instance.totalRequests,
  'requestsUnderThreshold': instance.requestsUnderThreshold,
  'compliancePercent': instance.compliancePercent,
};

_$SecurityMetricsModelImpl _$$SecurityMetricsModelImplFromJson(
  Map<String, dynamic> json,
) => _$SecurityMetricsModelImpl(
  unauthorizedAttempts401: (json['unauthorizedAttempts401'] as num).toInt(),
  forbiddenAttempts403: (json['forbiddenAttempts403'] as num).toInt(),
  totalProtectedEndpoints: (json['totalProtectedEndpoints'] as num).toInt(),
  endpointsWithAuthEnforced: (json['endpointsWithAuthEnforced'] as num).toInt(),
  accessControlCompliancePercent:
      (json['accessControlCompliancePercent'] as num).toDouble(),
);

Map<String, dynamic> _$$SecurityMetricsModelImplToJson(
  _$SecurityMetricsModelImpl instance,
) => <String, dynamic>{
  'unauthorizedAttempts401': instance.unauthorizedAttempts401,
  'forbiddenAttempts403': instance.forbiddenAttempts403,
  'totalProtectedEndpoints': instance.totalProtectedEndpoints,
  'endpointsWithAuthEnforced': instance.endpointsWithAuthEnforced,
  'accessControlCompliancePercent': instance.accessControlCompliancePercent,
};

_$MaintainabilityMetricsModelImpl _$$MaintainabilityMetricsModelImplFromJson(
  Map<String, dynamic> json,
) => _$MaintainabilityMetricsModelImpl(
  totalControllers: (json['totalControllers'] as num).toInt(),
  totalServices: (json['totalServices'] as num).toInt(),
  totalRepositories: (json['totalRepositories'] as num).toInt(),
  standardizedErrorHandlingEnabled:
      json['standardizedErrorHandlingEnabled'] as bool,
  jacocoCoverageGatePercent: (json['jacocoCoverageGatePercent'] as num).toInt(),
);

Map<String, dynamic> _$$MaintainabilityMetricsModelImplToJson(
  _$MaintainabilityMetricsModelImpl instance,
) => <String, dynamic>{
  'totalControllers': instance.totalControllers,
  'totalServices': instance.totalServices,
  'totalRepositories': instance.totalRepositories,
  'standardizedErrorHandlingEnabled': instance.standardizedErrorHandlingEnabled,
  'jacocoCoverageGatePercent': instance.jacocoCoverageGatePercent,
};

_$AppointmentsMetricsModelImpl _$$AppointmentsMetricsModelImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentsMetricsModelImpl(
  totalCreationAttempts: (json['totalCreationAttempts'] as num).toInt(),
  successfulAppointments: (json['successfulAppointments'] as num).toInt(),
  rejectedByBusinessRules: (json['rejectedByBusinessRules'] as num).toInt(),
  businessRuleCompliancePercent: (json['businessRuleCompliancePercent'] as num)
      .toDouble(),
  totalAppointmentsInDB: (json['totalAppointmentsInDB'] as num).toInt(),
  validRecordsInDB: (json['validRecordsInDB'] as num).toInt(),
  dataIntegrityPercent: (json['dataIntegrityPercent'] as num).toDouble(),
);

Map<String, dynamic> _$$AppointmentsMetricsModelImplToJson(
  _$AppointmentsMetricsModelImpl instance,
) => <String, dynamic>{
  'totalCreationAttempts': instance.totalCreationAttempts,
  'successfulAppointments': instance.successfulAppointments,
  'rejectedByBusinessRules': instance.rejectedByBusinessRules,
  'businessRuleCompliancePercent': instance.businessRuleCompliancePercent,
  'totalAppointmentsInDB': instance.totalAppointmentsInDB,
  'validRecordsInDB': instance.validRecordsInDB,
  'dataIntegrityPercent': instance.dataIntegrityPercent,
};

_$MetricsSummaryModelImpl _$$MetricsSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$MetricsSummaryModelImpl(
  performance: (json['performance'] as List<dynamic>)
      .map((e) => PerformanceMetricsModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  security: SecurityMetricsModel.fromJson(
    json['security'] as Map<String, dynamic>,
  ),
  maintainability: MaintainabilityMetricsModel.fromJson(
    json['maintainability'] as Map<String, dynamic>,
  ),
  appointments: AppointmentsMetricsModel.fromJson(
    json['appointments'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$MetricsSummaryModelImplToJson(
  _$MetricsSummaryModelImpl instance,
) => <String, dynamic>{
  'performance': instance.performance,
  'security': instance.security,
  'maintainability': instance.maintainability,
  'appointments': instance.appointments,
};

_$AdminLogModelImpl _$$AdminLogModelImplFromJson(Map<String, dynamic> json) =>
    _$AdminLogModelImpl(
      id: (json['id'] as num).toInt(),
      serviceName: json['serviceName'] as String,
      actionType: json['actionType'] as String,
      result: json['result'] as String,
      actorEmail: json['actorEmail'] as String?,
      actorUserId: (json['actorUserId'] as num?)?.toInt(),
      message: json['message'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$AdminLogModelImplToJson(_$AdminLogModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceName': instance.serviceName,
      'actionType': instance.actionType,
      'result': instance.result,
      'actorEmail': instance.actorEmail,
      'actorUserId': instance.actorUserId,
      'message': instance.message,
      'createdAt': instance.createdAt,
    };

_$AdminLogPageModelImpl _$$AdminLogPageModelImplFromJson(
  Map<String, dynamic> json,
) => _$AdminLogPageModelImpl(
  content: (json['content'] as List<dynamic>)
      .map((e) => AdminLogModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  page: (json['page'] as num).toInt(),
  size: (json['size'] as num).toInt(),
  totalElements: (json['totalElements'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  first: json['first'] as bool,
  last: json['last'] as bool,
  empty: json['empty'] as bool,
);

Map<String, dynamic> _$$AdminLogPageModelImplToJson(
  _$AdminLogPageModelImpl instance,
) => <String, dynamic>{
  'content': instance.content,
  'page': instance.page,
  'size': instance.size,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'first': instance.first,
  'last': instance.last,
  'empty': instance.empty,
};
