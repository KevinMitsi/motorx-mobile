import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

/// Remote data source for authentication endpoints.
/// Handles raw HTTP calls via Dio and throws [ServerException] on failure.
class AuthRemoteDatasource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);

  Future<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      // Error body may be a plain String or a Map depending on the endpoint.
      final rawData = e.response?.data;
      Map<String, dynamic>? dataMap;
      if (rawData is Map<String, dynamic>) {
        dataMap = rawData;
      } else if (rawData is String && rawData.isNotEmpty) {
        try {
          final decoded = jsonDecode(rawData);
          if (decoded is Map<String, dynamic>) dataMap = decoded;
        } catch (_) {}
      }
      throw ServerException(
        message: dataMap?['message']?.toString() ??
            rawData?.toString() ??
            'Error del servidor',
        statusCode: e.response?.statusCode ?? 500,
        details: dataMap,
      );
    }
  }

  /// POST /api/auth/login
  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
        options: Options(responseType: ResponseType.plain),
      );
      // Try to decode as JSON — ADMIN login returns a token object.
      // Non-admin login returns a plain-text 2FA message.
      try {
        final decoded = jsonDecode(response.data as String);
        if (decoded is Map<String, dynamic> && decoded.containsKey('token')) {
          return AuthResponseModel.fromJson(decoded);
        }
        return decoded;
      } catch (_) {
        // Plain text → 2FA message
        return response.data;
      }
    });
  }

  /// POST /api/auth/verify-2fa
  Future<AuthResponseModel> verify2fa({
    required String email,
    required String code,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.verify2fa,
        data: {'email': email, 'code': code},
      );
      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  /// POST /api/auth/register
  Future<AuthResponseModel> register({
    required String name,
    required String dni,
    required String email,
    required String password,
    required String phone,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'dni': dni,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );
      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  /// GET /api/auth/me
  Future<UserModel> getMe() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.me);
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  /// GET /api/auth/logout
  Future<void> logout() async {
    return _handleRequest(() async {
      await _dio.get(ApiEndpoints.logout);
    });
  }

  /// POST /api/password-reset/request
  Future<String> requestPasswordReset({required String email}) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.passwordResetRequest,
        data: {'email': email},
        options: Options(responseType: ResponseType.plain),
      );
      return response.data?.toString() ?? 'Solicitud procesada';
    });
  }

  /// PUT /api/password-reset
  Future<String> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.put(
        ApiEndpoints.passwordReset,
        data: {'token': token, 'newPassword': newPassword},
        options: Options(responseType: ResponseType.plain),
      );
      return response.data?.toString() ?? 'Contraseña restablecida';
    });
  }

  /// POST /api/auth/refresh
  Future<AuthResponseModel> refreshToken({
    required String refreshToken,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.refreshToken,
        queryParameters: {'refreshToken': refreshToken},
      );
      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    });
  }
}
