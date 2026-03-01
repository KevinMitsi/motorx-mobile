import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/appointment_model.dart';

/// Remote data source for user appointment operations.
class AppointmentRemoteDatasource {
  final Dio _dio;

  AppointmentRemoteDatasource(this._dio);

  Future<AvailableSlotsModel> getAvailableSlots({
    required String date,
    required String type,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.get(
        ApiEndpoints.userAvailableSlots,
        queryParameters: {'date': date, 'type': type},
      );
      return AvailableSlotsModel.fromJson(response.data);
    });
  }

  Future<PlateRestrictionModel> checkPlateRestriction({
    required int vehicleId,
    required String date,
  }) async {
    // This endpoint always returns 409 — both for restricted and not restricted
    try {
      final response = await _dio.get(
        ApiEndpoints.userCheckPlateRestriction,
        queryParameters: {'vehicleId': vehicleId, 'date': date},
      );
      return PlateRestrictionModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        // 409 is expected — parse the response body
        return PlateRestrictionModel.fromJson(e.response!.data);
      }
      rethrow;
    }
  }

  Future<ReworkInfoModel> getReworkInfo() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.userReworkInfo);
      return ReworkInfoModel.fromJson(response.data);
    });
  }

  Future<AppointmentModel> createAppointment({
    required int vehicleId,
    required String appointmentType,
    required String appointmentDate,
    required String startTime,
    required int currentMileage,
    List<String>? clientNotes,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.userCreateAppointment,
        data: {
          'vehicleId': vehicleId,
          'appointmentType': appointmentType,
          'appointmentDate': appointmentDate,
          'startTime': startTime,
          'currentMileage': currentMileage,
          if (clientNotes != null && clientNotes.isNotEmpty)
            'clientNotes': clientNotes,
        },
      );
      return AppointmentModel.fromJson(response.data);
    });
  }

  Future<List<AppointmentModel>> getMyAppointments() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.userMyAppointments);
      return (response.data as List)
          .map((e) => AppointmentModel.fromJson(e))
          .toList();
    });
  }

  Future<AppointmentModel> getAppointmentDetail(int id) async {
    return _handleRequest(() async {
      final response =
          await _dio.get(ApiEndpoints.userMyAppointmentDetail(id));
      return AppointmentModel.fromJson(response.data);
    });
  }

  Future<List<AppointmentModel>> getVehicleAppointments(
      int vehicleId) async {
    return _handleRequest(() async {
      final response =
          await _dio.get(ApiEndpoints.userVehicleAppointments(vehicleId));
      return (response.data as List)
          .map((e) => AppointmentModel.fromJson(e))
          .toList();
    });
  }

  Future<AppointmentModel> cancelAppointment(int id) async {
    return _handleRequest(() async {
      final response =
          await _dio.delete(ApiEndpoints.userCancelAppointment(id));
      return AppointmentModel.fromJson(response.data);
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
