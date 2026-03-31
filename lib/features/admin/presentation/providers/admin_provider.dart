import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_client.dart';
import '../../../appointments/domain/entities/appointment_entity.dart';
import '../../../appointments/data/models/appointment_model.dart';
import '../../../vehicles/data/models/vehicle_model.dart';
import '../../../vehicles/domain/entities/vehicle_entity.dart';
import '../../data/datasources/admin_remote_datasource.dart';
import '../../data/models/admin_models.dart';
import '../../domain/entities/admin_entities.dart';

part 'admin_provider.g.dart';

/// Provides the admin datasource.
@riverpod
AdminRemoteDatasource adminDatasource(AdminDatasourceRef ref) {
  return AdminRemoteDatasource(ref.watch(dioClientProvider));
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ADMIN APPOINTMENTS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Manages admin agenda (appointments for a specific date).
@riverpod
class AdminAgendaNotifier extends _$AdminAgendaNotifier {
  @override
  Future<List<AppointmentEntity>> build() async => [];

  Future<void> fetchAgenda(String date) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ds = ref.read(adminDatasourceProvider);
      final models = await ds.getAgenda(date);
      return models.map(_mapAppointment).toList();
    });
  }
}

/// Manages admin calendar (appointments within date range).
@riverpod
class AdminCalendarNotifier extends _$AdminCalendarNotifier {
  @override
  Future<List<AppointmentEntity>> build() async => [];

  Future<void> fetchCalendar(String start, String end) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ds = ref.read(adminDatasourceProvider);
      final models = await ds.getCalendar(start, end);
      return models.map(_mapAppointment).toList();
    });
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ADMIN EMPLOYEES
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

@riverpod
class AdminEmployeeNotifier extends _$AdminEmployeeNotifier {
  @override
  Future<List<EmployeeEntity>> build() async {
    final ds = ref.watch(adminDatasourceProvider);
    final models = await ds.getEmployees();
    return models.map(_mapEmployee).toList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ds = ref.read(adminDatasourceProvider);
      final models = await ds.getEmployees();
      return models.map(_mapEmployee).toList();
    });
  }

  Future<EmployeeEntity> createEmployee({
    required String position,
    required String name,
    required String dni,
    required String email,
    required String password,
    required String phone,
  }) async {
    final ds = ref.read(adminDatasourceProvider);
    final model = await ds.createEmployee(
      position: position,
      name: name,
      dni: dni,
      email: email,
      password: password,
      phone: phone,
    );
    final entity = _mapEmployee(model);
    final current = state.valueOrNull ?? [];
    state = AsyncData([entity, ...current]);
    return entity;
  }

  Future<void> updateEmployee({
    required int id,
    required String position,
    required String employeeState,
  }) async {
    final ds = ref.read(adminDatasourceProvider);
    final model = await ds.updateEmployee(
      id: id,
      position: position,
      state: employeeState,
    );
    final entity = _mapEmployee(model);
    final current = state.valueOrNull ?? [];
    state = AsyncData(
      current.map((e) => e.employeeId == id ? entity : e).toList(),
    );
  }

  Future<void> deleteEmployee(int id) async {
    final ds = ref.read(adminDatasourceProvider);
    await ds.deleteEmployee(id);
    final current = state.valueOrNull ?? [];
    state = AsyncData(current.where((e) => e.employeeId != id).toList());
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ADMIN USERS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

@riverpod
class AdminUserNotifier extends _$AdminUserNotifier {
  @override
  Future<List<AdminUserEntity>> build() async {
    final ds = ref.watch(adminDatasourceProvider);
    final models = await ds.getUsers();
    return models.map(_mapUser).toList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ds = ref.read(adminDatasourceProvider);
      final models = await ds.getUsers();
      return models.map(_mapUser).toList();
    });
  }

  Future<void> blockUser(int id) async {
    final ds = ref.read(adminDatasourceProvider);
    final model = await ds.blockUser(id);
    final entity = _mapUser(model);
    _updateUser(id, entity);
  }

  Future<void> unblockUser(int id) async {
    final ds = ref.read(adminDatasourceProvider);
    final model = await ds.unblockUser(id);
    final entity = _mapUser(model);
    _updateUser(id, entity);
  }

  Future<void> deleteUser(int id) async {
    final ds = ref.read(adminDatasourceProvider);
    await ds.deleteUser(id);
    await refresh();
  }

  void _updateUser(int id, AdminUserEntity updated) {
    final current = state.valueOrNull ?? [];
    state = AsyncData(current.map((u) => u.id == id ? updated : u).toList());
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ADMIN VEHICLES
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

@riverpod
class AdminVehicleNotifier extends _$AdminVehicleNotifier {
  @override
  Future<List<VehicleEntity>> build() async {
    final ds = ref.watch(adminDatasourceProvider);
    final models = await ds.getAllVehicles();
    return models.map(_mapVehicle).toList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ds = ref.read(adminDatasourceProvider);
      final models = await ds.getAllVehicles();
      return models.map(_mapVehicle).toList();
    });
  }

  Future<void> transferOwnership({
    required int vehicleId,
    required int newOwnerId,
  }) async {
    final ds = ref.read(adminDatasourceProvider);
    final model = await ds.transferOwnership(
      vehicleId: vehicleId,
      newOwnerId: newOwnerId,
    );
    final entity = _mapVehicle(model);
    final current = state.valueOrNull ?? [];
    state = AsyncData(
      current.map((v) => v.id == vehicleId ? entity : v).toList(),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ADMIN METRICS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

@riverpod
class AdminMetricsNotifier extends _$AdminMetricsNotifier {
  @override
  Future<MetricsSummaryEntity> build() async {
    final ds = ref.watch(adminDatasourceProvider);
    final model = await ds.getMetricsSummary();
    return _mapMetricsSummary(model);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ds = ref.read(adminDatasourceProvider);
      final model = await ds.getMetricsSummary();
      return _mapMetricsSummary(model);
    });
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ADMIN LOGS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class AdminLogFilters {
  final String? serviceName;
  final String? actionType;
  final String? result;
  final String? actorEmail;
  final int? actorUserId;
  final String? from;
  final String? to;

  const AdminLogFilters({
    this.serviceName,
    this.actionType,
    this.result,
    this.actorEmail,
    this.actorUserId,
    this.from,
    this.to,
  });
}

@riverpod
class AdminLogsNotifier extends _$AdminLogsNotifier {
  AdminLogFilters _filters = const AdminLogFilters();
  int _page = 0;
  int _size = 20;

  @override
  Future<AdminLogPageEntity> build() async {
    final ds = ref.watch(adminDatasourceProvider);
    final model = await ds.getLogs(page: _page, size: _size);
    return _mapAdminLogPage(model);
  }

  Future<void> fetchLogs({
    AdminLogFilters filters = const AdminLogFilters(),
    int page = 0,
    int size = 20,
  }) async {
    _filters = filters;
    _page = page;
    _size = size;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ds = ref.read(adminDatasourceProvider);
      final model = await ds.getLogs(
        serviceName: filters.serviceName,
        actionType: filters.actionType,
        result: filters.result,
        actorEmail: filters.actorEmail,
        actorUserId: filters.actorUserId,
        from: filters.from,
        to: filters.to,
        page: page,
        size: size,
      );
      return _mapAdminLogPage(model);
    });
  }

  Future<void> refresh() async {
    await fetchLogs(filters: _filters, page: _page, size: _size);
  }

  Future<void> nextPage() async {
    final current = state.valueOrNull;
    if (current == null || current.last) return;
    await fetchLogs(filters: _filters, page: _page + 1, size: _size);
  }

  Future<void> previousPage() async {
    if (_page <= 0) return;
    await fetchLogs(filters: _filters, page: _page - 1, size: _size);
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// MAPPERS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

AppointmentEntity _mapAppointment(AppointmentModel m) => AppointmentEntity(
  id: m.id,
  appointmentType: m.appointmentType,
  status: m.status,
  appointmentDate: m.appointmentDate,
  startTime: m.startTime,
  endTime: m.endTime,
  vehicleId: m.vehicleId,
  vehiclePlate: m.vehiclePlate,
  vehicleBrand: m.vehicleBrand,
  vehicleModel: m.vehicleModel,
  clientId: m.clientId,
  clientFullName: m.clientFullName,
  clientEmail: m.clientEmail,
  technicianId: m.technicianId,
  technicianFullName: m.technicianFullName,
  currentMileage: m.currentMileage,
  clientNotes: m.clientNotes,
  adminNotes: m.adminNotes,
  createdAt: m.createdAt,
  updatedAt: m.updatedAt,
);

EmployeeEntity _mapEmployee(EmployeeModel m) => EmployeeEntity(
  employeeId: m.employeeId,
  position: m.position,
  state: m.state,
  hireDate: m.hireDate,
  userId: m.userId,
  userName: m.userName,
  userEmail: m.userEmail,
  userDni: m.userDni,
  userPhone: m.userPhone,
  createdAt: m.createdAt,
  updatedAt: m.updatedAt,
);

AdminUserEntity _mapUser(AdminUserModel m) => AdminUserEntity(
  id: m.id,
  name: m.name,
  dni: m.dni,
  email: m.email,
  phone: m.phone,
  role: m.role,
  enabled: m.enabled,
  accountLocked: m.accountLocked,
  createdAt: m.createdAt,
  updatedAt: m.updatedAt,
  deletedAt: m.deletedAt,
);

VehicleEntity _mapVehicle(VehicleModel m) => VehicleEntity(
  id: m.id,
  brand: m.brand,
  model: m.model,
  yearOfManufacture: m.yearOfManufacture,
  licensePlate: m.licensePlate,
  cylinderCapacity: m.cylinderCapacity,
  chassisNumber: m.chassisNumber,
  ownerId: m.ownerId,
  ownerName: m.ownerName,
  ownerEmail: m.ownerEmail,
  createdAt: m.createdAt,
  updatedAt: m.updatedAt,
);

PerformanceMetricsEntity _mapPerformanceMetrics(PerformanceMetricsModel m) =>
    PerformanceMetricsEntity(
      endpoint: m.endpoint,
      avgResponseTimeMs: m.avgResponseTimeMs,
      totalRequests: m.totalRequests,
      requestsUnderThreshold: m.requestsUnderThreshold,
      compliancePercent: m.compliancePercent,
    );

SecurityMetricsEntity _mapSecurityMetrics(SecurityMetricsModel m) =>
    SecurityMetricsEntity(
      unauthorizedAttempts401: m.unauthorizedAttempts401,
      forbiddenAttempts403: m.forbiddenAttempts403,
      totalProtectedEndpoints: m.totalProtectedEndpoints,
      endpointsWithAuthEnforced: m.endpointsWithAuthEnforced,
      accessControlCompliancePercent: m.accessControlCompliancePercent,
    );

MaintainabilityMetricsEntity _mapMaintainabilityMetrics(
  MaintainabilityMetricsModel m,
) => MaintainabilityMetricsEntity(
  totalControllers: m.totalControllers,
  totalServices: m.totalServices,
  totalRepositories: m.totalRepositories,
  standardizedErrorHandlingEnabled: m.standardizedErrorHandlingEnabled,
  jacocoCoverageGatePercent: m.jacocoCoverageGatePercent,
);

AppointmentsMetricsEntity _mapAppointmentsMetrics(AppointmentsMetricsModel m) =>
    AppointmentsMetricsEntity(
      totalCreationAttempts: m.totalCreationAttempts,
      successfulAppointments: m.successfulAppointments,
      rejectedByBusinessRules: m.rejectedByBusinessRules,
      businessRuleCompliancePercent: m.businessRuleCompliancePercent,
      totalAppointmentsInDB: m.totalAppointmentsInDB,
      validRecordsInDB: m.validRecordsInDB,
      dataIntegrityPercent: m.dataIntegrityPercent,
    );

MetricsSummaryEntity _mapMetricsSummary(MetricsSummaryModel m) =>
    MetricsSummaryEntity(
      performance: m.performance.map(_mapPerformanceMetrics).toList(),
      security: _mapSecurityMetrics(m.security),
      maintainability: _mapMaintainabilityMetrics(m.maintainability),
      appointments: _mapAppointmentsMetrics(m.appointments),
    );

AdminLogEntity _mapAdminLog(AdminLogModel m) => AdminLogEntity(
  id: m.id,
  serviceName: m.serviceName,
  actionType: m.actionType,
  result: m.result,
  actorEmail: m.actorEmail,
  actorUserId: m.actorUserId,
  message: m.message,
  createdAt: m.createdAt,
);

AdminLogPageEntity _mapAdminLogPage(AdminLogPageModel m) => AdminLogPageEntity(
  content: m.content.map(_mapAdminLog).toList(),
  page: m.page,
  size: m.size,
  totalElements: m.totalElements,
  totalPages: m.totalPages,
  first: m.first,
  last: m.last,
  empty: m.empty,
);
