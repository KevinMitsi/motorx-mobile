import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_models.freezed.dart';
part 'admin_models.g.dart';

/// Model matching `EmployeeResponseDTO` from the API.
@freezed
class EmployeeModel with _$EmployeeModel {
  const factory EmployeeModel({
    required int employeeId,
    required String position,
    required String state,
    required String hireDate,
    required int userId,
    required String userName,
    required String userEmail,
    required String userDni,
    required String userPhone,
    required String createdAt,
    required String updatedAt,
  }) = _EmployeeModel;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);
}

/// Model matching `AdminUserResponseDTO` from the API.
@freezed
class AdminUserModel with _$AdminUserModel {
  const factory AdminUserModel({
    required int id,
    required String name,
    required String dni,
    required String email,
    required String phone,
    required String role,
    required bool enabled,
    required bool accountLocked,
    required String createdAt,
    required String updatedAt,
    String? deletedAt,
  }) = _AdminUserModel;

  factory AdminUserModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUserModelFromJson(json);
}

/// Model matching `PerformanceMetricsDTO` from the API.
@freezed
class PerformanceMetricsModel with _$PerformanceMetricsModel {
  const factory PerformanceMetricsModel({
    required String endpoint,
    required int avgResponseTimeMs,
    required int totalRequests,
    required int requestsUnderThreshold,
    required double compliancePercent,
  }) = _PerformanceMetricsModel;

  factory PerformanceMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricsModelFromJson(json);
}

/// Model matching `SecurityMetricsDTO` from the API.
@freezed
class SecurityMetricsModel with _$SecurityMetricsModel {
  const factory SecurityMetricsModel({
    required int unauthorizedAttempts401,
    required int forbiddenAttempts403,
    required int totalProtectedEndpoints,
    required int endpointsWithAuthEnforced,
    required double accessControlCompliancePercent,
  }) = _SecurityMetricsModel;

  factory SecurityMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$SecurityMetricsModelFromJson(json);
}

/// Model matching `MaintainabilityMetricsDTO` from the API.
@freezed
class MaintainabilityMetricsModel with _$MaintainabilityMetricsModel {
  const factory MaintainabilityMetricsModel({
    required int totalControllers,
    required int totalServices,
    required int totalRepositories,
    required bool standardizedErrorHandlingEnabled,
    required int jacocoCoverageGatePercent,
  }) = _MaintainabilityMetricsModel;

  factory MaintainabilityMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$MaintainabilityMetricsModelFromJson(json);
}

/// Model matching `AppointmentsMetricsDTO` from the API.
@freezed
class AppointmentsMetricsModel with _$AppointmentsMetricsModel {
  const factory AppointmentsMetricsModel({
    required int totalCreationAttempts,
    required int successfulAppointments,
    required int rejectedByBusinessRules,
    required double businessRuleCompliancePercent,
    required int totalAppointmentsInDB,
    required int validRecordsInDB,
    required double dataIntegrityPercent,
  }) = _AppointmentsMetricsModel;

  factory AppointmentsMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentsMetricsModelFromJson(json);
}

/// Model matching `MetricsSummaryDTO` from the API.
@freezed
class MetricsSummaryModel with _$MetricsSummaryModel {
  const factory MetricsSummaryModel({
    required List<PerformanceMetricsModel> performance,
    required SecurityMetricsModel security,
    required MaintainabilityMetricsModel maintainability,
    required AppointmentsMetricsModel appointments,
  }) = _MetricsSummaryModel;

  factory MetricsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$MetricsSummaryModelFromJson(json);
}

/// Model matching a single log item in `LogPageResponseDTO`.
@freezed
class AdminLogModel with _$AdminLogModel {
  const factory AdminLogModel({
    required int id,
    required String serviceName,
    required String actionType,
    required String result,
    String? actorEmail,
    int? actorUserId,
    required String message,
    required String createdAt,
  }) = _AdminLogModel;

  factory AdminLogModel.fromJson(Map<String, dynamic> json) =>
      _$AdminLogModelFromJson(json);
}

/// Model matching paginated `LogPageResponseDTO` from the API.
@freezed
class AdminLogPageModel with _$AdminLogPageModel {
  const factory AdminLogPageModel({
    required List<AdminLogModel> content,
    required int page,
    required int size,
    required int totalElements,
    required int totalPages,
    required bool first,
    required bool last,
    required bool empty,
  }) = _AdminLogPageModel;

  factory AdminLogPageModel.fromJson(Map<String, dynamic> json) =>
      _$AdminLogPageModelFromJson(json);
}
