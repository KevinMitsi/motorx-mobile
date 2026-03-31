/// Pure domain entity for Employee.
class EmployeeEntity {
  final int employeeId;
  final String position;
  final String state;
  final String hireDate;
  final int userId;
  final String userName;
  final String userEmail;
  final String userDni;
  final String userPhone;
  final String createdAt;
  final String updatedAt;

  const EmployeeEntity({
    required this.employeeId,
    required this.position,
    required this.state,
    required this.hireDate,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userDni,
    required this.userPhone,
    required this.createdAt,
    required this.updatedAt,
  });
}

/// Pure domain entity for admin-view user.
class AdminUserEntity {
  final int id;
  final String name;
  final String dni;
  final String email;
  final String phone;
  final String role;
  final bool enabled;
  final bool accountLocked;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  const AdminUserEntity({
    required this.id,
    required this.name,
    required this.dni,
    required this.email,
    required this.phone,
    required this.role,
    required this.enabled,
    required this.accountLocked,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  bool get isDeleted => deletedAt != null;
}

/// Pure domain entity for performance metrics.
class PerformanceMetricsEntity {
  final String endpoint;
  final int avgResponseTimeMs;
  final int totalRequests;
  final int requestsUnderThreshold;
  final double compliancePercent;

  const PerformanceMetricsEntity({
    required this.endpoint,
    required this.avgResponseTimeMs,
    required this.totalRequests,
    required this.requestsUnderThreshold,
    required this.compliancePercent,
  });
}

/// Pure domain entity for security metrics.
class SecurityMetricsEntity {
  final int unauthorizedAttempts401;
  final int forbiddenAttempts403;
  final int totalProtectedEndpoints;
  final int endpointsWithAuthEnforced;
  final double accessControlCompliancePercent;

  const SecurityMetricsEntity({
    required this.unauthorizedAttempts401,
    required this.forbiddenAttempts403,
    required this.totalProtectedEndpoints,
    required this.endpointsWithAuthEnforced,
    required this.accessControlCompliancePercent,
  });
}

/// Pure domain entity for maintainability metrics.
class MaintainabilityMetricsEntity {
  final int totalControllers;
  final int totalServices;
  final int totalRepositories;
  final bool standardizedErrorHandlingEnabled;
  final int jacocoCoverageGatePercent;

  const MaintainabilityMetricsEntity({
    required this.totalControllers,
    required this.totalServices,
    required this.totalRepositories,
    required this.standardizedErrorHandlingEnabled,
    required this.jacocoCoverageGatePercent,
  });
}

/// Pure domain entity for appointments metrics.
class AppointmentsMetricsEntity {
  final int totalCreationAttempts;
  final int successfulAppointments;
  final int rejectedByBusinessRules;
  final double businessRuleCompliancePercent;
  final int totalAppointmentsInDB;
  final int validRecordsInDB;
  final double dataIntegrityPercent;

  const AppointmentsMetricsEntity({
    required this.totalCreationAttempts,
    required this.successfulAppointments,
    required this.rejectedByBusinessRules,
    required this.businessRuleCompliancePercent,
    required this.totalAppointmentsInDB,
    required this.validRecordsInDB,
    required this.dataIntegrityPercent,
  });
}

/// Pure domain entity for metrics summary.
class MetricsSummaryEntity {
  final List<PerformanceMetricsEntity> performance;
  final SecurityMetricsEntity security;
  final MaintainabilityMetricsEntity maintainability;
  final AppointmentsMetricsEntity appointments;

  const MetricsSummaryEntity({
    required this.performance,
    required this.security,
    required this.maintainability,
    required this.appointments,
  });
}

/// Pure domain entity for a single admin log row.
class AdminLogEntity {
  final int id;
  final String serviceName;
  final String actionType;
  final String result;
  final String? actorEmail;
  final int? actorUserId;
  final String message;
  final String createdAt;

  const AdminLogEntity({
    required this.id,
    required this.serviceName,
    required this.actionType,
    required this.result,
    this.actorEmail,
    this.actorUserId,
    required this.message,
    required this.createdAt,
  });
}

/// Pure domain entity for paginated logs response.
class AdminLogPageEntity {
  final List<AdminLogEntity> content;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool first;
  final bool last;
  final bool empty;

  const AdminLogPageEntity({
    required this.content,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.first,
    required this.last,
    required this.empty,
  });
}
