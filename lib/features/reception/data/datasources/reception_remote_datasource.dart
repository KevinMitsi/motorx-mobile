import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';

class ReceptionRemoteDatasource {
  final Dio _dio;

  ReceptionRemoteDatasource(this._dio);

  Future<String> initiateReception(int appointmentId) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.receptionInitiate(appointmentId),
      );
      if (response.data is String) return response.data as String;
      if (response.data is Map && response.data['message'] != null) {
        return response.data['message'].toString();
      }
      return 'Recepción iniciada. Código enviado por correo.';
    });
  }

  Future<String> confirmReception({
    required String vehiclePlate,
    required String code,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.receptionConfirm,
        data: {'vehiclePlate': vehiclePlate, 'code': code},
      );
      if (response.data is String) return response.data as String;
      if (response.data is Map && response.data['message'] != null) {
        return response.data['message'].toString();
      }
      return 'Recepción confirmada correctamente';
    });
  }

  Future<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map ? data['message']?.toString() : null;
      throw ServerException(
        message: message ?? e.message ?? 'Error del servidor',
        statusCode: e.response?.statusCode ?? 500,
        details: data is Map<String, dynamic> ? data : null,
      );
    }
  }
}
