import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_endpoints.dart';

/// Secure storage provider for token persistence.
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
});

/// Dio singleton via Riverpod provider.
/// Includes auth interceptor that automatically injects Bearer token
/// and handles 401 responses.
final dioClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Logging interceptor — only in debug mode
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
  }

  // Auth interceptor — injects token and handles 401
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final storage = ref.read(secureStorageProvider);
        final token = await storage.read(key: 'access_token');
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Try to refresh token
          final storage = ref.read(secureStorageProvider);
          final refreshToken = await storage.read(key: 'refresh_token');
          if (refreshToken != null && refreshToken.isNotEmpty) {
            try {
              final refreshDio = Dio(
                BaseOptions(baseUrl: ApiEndpoints.baseUrl),
              );
              final response = await refreshDio.post(
                ApiEndpoints.refreshToken,
                queryParameters: {'refreshToken': refreshToken},
              );
              final newToken = response.data['token'] as String;
              await storage.write(key: 'access_token', value: newToken);

              // Retry original request with new token
              error.requestOptions.headers['Authorization'] =
                  'Bearer $newToken';
              final retryResponse = await dio.fetch(error.requestOptions);
              return handler.resolve(retryResponse);
            } catch (_) {
              // Refresh failed — clear tokens
              await storage.deleteAll();
            }
          }
        }
        handler.next(error);
      },
    ),
  );

  return dio;
});
