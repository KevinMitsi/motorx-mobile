import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';

class ChatbotRemoteDatasource {
  final Dio _dio;

  ChatbotRemoteDatasource(this._dio);

  Future<String> sendMessage(String message) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.chatbotMessage,
        data: {'message': message},
        options: Options(
          connectTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 90),
        ),
      );

      final data = response.data;
      if (data is Map && data['reply'] != null) {
        return data['reply'].toString();
      }
      if (data is String && data.trim().isNotEmpty) {
        return data;
      }
      return 'No fue posible obtener respuesta en este momento.';
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
