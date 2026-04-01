import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../data/models/admin_models.dart';
import '../../../appointments/data/models/appointment_model.dart';
import '../../../vehicles/data/models/vehicle_model.dart';

/// Remote data source for all admin operations.
class AdminRemoteDatasource {
  final Dio _dio;

  AdminRemoteDatasource(this._dio);

  // ── Admin Appointments ────────────────────────────────────

  Future<List<AppointmentModel>> getAgenda(String date) async {
    return _handleRequest(() async {
      final response = await _dio.get(
        ApiEndpoints.adminAgenda,
        queryParameters: {'date': date},
      );
      return (response.data as List)
          .map((e) => AppointmentModel.fromJson(e))
          .toList();
    });
  }

  Future<List<AppointmentModel>> getCalendar(String start, String end) async {
    return _handleRequest(() async {
      final response = await _dio.get(
        ApiEndpoints.adminCalendar,
        queryParameters: {'start': start, 'end': end},
      );
      return (response.data as List)
          .map((e) => AppointmentModel.fromJson(e))
          .toList();
    });
  }

  Future<AvailableSlotsModel> getAdminAvailableSlots({
    required String date,
    required String type,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.get(
        ApiEndpoints.adminAvailableSlots,
        queryParameters: {'date': date, 'type': type},
      );
      return AvailableSlotsModel.fromJson(response.data);
    });
  }

  Future<AppointmentModel> createUnplannedAppointment({
    required int vehicleId,
    required String appointmentDate,
    required String startTime,
    required int currentMileage,
    int? technicianId,
    String? adminNotes,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.adminUnplannedAppointment,
        data: {
          'vehicleId': vehicleId,
          'appointmentType': 'UNPLANNED',
          'appointmentDate': appointmentDate,
          'startTime': startTime,
          'currentMileage': currentMileage,
          if (technicianId != null) 'technicianId': technicianId,
          if (adminNotes != null) 'adminNotes': adminNotes,
        },
      );
      return AppointmentModel.fromJson(response.data);
    });
  }

  Future<AppointmentModel> cancelAppointment({
    required int appointmentId,
    required String reason,
    required bool notifyClient,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.patch(
        ApiEndpoints.adminCancelAppointment(appointmentId),
        data: {'reason': reason, 'notifyClient': notifyClient},
      );
      return AppointmentModel.fromJson(response.data);
    });
  }

  Future<AppointmentModel> changeTechnician({
    required int appointmentId,
    required int newTechnicianId,
    required bool notifyClient,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.patch(
        ApiEndpoints.adminChangeTechnician(appointmentId),
        data: {
          'newTechnicianId': newTechnicianId,
          'notifyClient': notifyClient,
        },
      );
      return AppointmentModel.fromJson(response.data);
    });
  }

  Future<AppointmentModel> getAppointmentDetail(int id) async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminAppointmentDetail(id));
      return AppointmentModel.fromJson(response.data);
    });
  }

  // ── Admin Employees ───────────────────────────────────────

  Future<List<EmployeeModel>> getEmployees() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminEmployees);
      return (response.data as List)
          .map((e) => EmployeeModel.fromJson(e))
          .toList();
    });
  }

  Future<EmployeeModel> getEmployeeDetail(int id) async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminEmployeeDetail(id));
      return EmployeeModel.fromJson(response.data);
    });
  }

  Future<EmployeeModel> createEmployee({
    required String position,
    required String name,
    required String dni,
    required String email,
    required String password,
    required String phone,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.adminEmployees,
        data: {
          'position': position,
          'user': {
            'name': name,
            'dni': dni,
            'email': email,
            'password': password,
            'phone': phone,
          },
        },
      );
      return EmployeeModel.fromJson(response.data);
    });
  }

  Future<EmployeeModel> updateEmployee({
    required int id,
    required String position,
    required String state,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.put(
        ApiEndpoints.adminEmployeeDetail(id),
        data: {'position': position, 'state': state},
      );
      return EmployeeModel.fromJson(response.data);
    });
  }

  Future<void> deleteEmployee(int id) async {
    return _handleRequest(() async {
      await _dio.delete(ApiEndpoints.adminEmployeeDetail(id));
    });
  }

  // ── Admin Users ───────────────────────────────────────────

  Future<List<AdminUserModel>> getUsers() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminUsers);
      return (response.data as List)
          .map((e) => AdminUserModel.fromJson(e))
          .toList();
    });
  }

  Future<AdminUserModel> getUserDetail(int id) async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminUserDetail(id));
      return AdminUserModel.fromJson(response.data);
    });
  }

  Future<AdminUserModel> blockUser(int id) async {
    return _handleRequest(() async {
      final response = await _dio.patch(ApiEndpoints.adminBlockUser(id));
      return AdminUserModel.fromJson(response.data);
    });
  }

  Future<AdminUserModel> unblockUser(int id) async {
    return _handleRequest(() async {
      final response = await _dio.patch(ApiEndpoints.adminUnblockUser(id));
      return AdminUserModel.fromJson(response.data);
    });
  }

  Future<void> deleteUser(int id) async {
    return _handleRequest(() async {
      await _dio.delete(ApiEndpoints.adminDeleteUser(id));
    });
  }

  // ── Admin Vehicles ────────────────────────────────────────

  Future<List<VehicleModel>> getAllVehicles() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminVehicles);
      return (response.data as List)
          .map((e) => VehicleModel.fromJson(e))
          .toList();
    });
  }

  Future<VehicleModel> getAdminVehicleDetail(int id) async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminVehicleDetail(id));
      return VehicleModel.fromJson(response.data);
    });
  }

  Future<VehicleModel> transferOwnership({
    required int vehicleId,
    required int newOwnerId,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.patch(
        ApiEndpoints.adminTransferOwnership(vehicleId),
        data: {'newOwnerId': newOwnerId},
      );
      return VehicleModel.fromJson(response.data);
    });
  }

  // ── Admin Metrics ────────────────────────────────────────

  Future<List<PerformanceMetricsModel>> getPerformanceMetrics() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminMetricsPerformance);
      return (response.data as List)
          .map((e) => PerformanceMetricsModel.fromJson(e))
          .toList();
    });
  }

  Future<SecurityMetricsModel> getSecurityMetrics() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminMetricsSecurity);
      return SecurityMetricsModel.fromJson(response.data);
    });
  }

  Future<MaintainabilityMetricsModel> getMaintainabilityMetrics() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminMetricsMaintainability);
      return MaintainabilityMetricsModel.fromJson(response.data);
    });
  }

  Future<AppointmentsMetricsModel> getAppointmentsMetrics() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminMetricsAppointments);
      return AppointmentsMetricsModel.fromJson(response.data);
    });
  }

  Future<MetricsSummaryModel> getMetricsSummary() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.adminMetricsSummary);
      return MetricsSummaryModel.fromJson(response.data);
    });
  }

  // ── Admin Logs ───────────────────────────────────────────

  Future<AdminLogPageModel> getLogs({
    int page = 0,
    int size = 20,
    String sort = 'createdAt,desc',
  }) async {
    return _handleRequest(() async {
      final queryParameters = <String, dynamic>{
        'page': page,
        'size': size,
        'sort': sort,
      };

      final response = await _dio.get(
        ApiEndpoints.adminLogs,
        queryParameters: queryParameters,
      );
      return AdminLogPageModel.fromJson(response.data);
    });
  }

  // ── Private helpers ───────────────────────────────────────
  Future<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;
      final message = data is Map ? data['message'] as String? : null;
      throw ServerException(
        message: message ?? e.message ?? 'Error del servidor',
        statusCode: statusCode ?? 500,
        details: data is Map ? data['details'] : null,
      );
    }
  }
}
