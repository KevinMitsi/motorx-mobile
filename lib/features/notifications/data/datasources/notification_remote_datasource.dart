import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/notification_model.dart';

class NotificationRemoteDatasource {
  final Dio _dio;

  NotificationRemoteDatasource(this._dio);

  Future<List<NotificationModel>> getMyNotifications({
    bool onlyUnread = false,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.get(
        ApiEndpoints.notificationsMy,
        queryParameters: {'onlyUnread': onlyUnread},
      );
      return (response.data as List)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<NotificationModel>> getNotificationsByUser(int userId) async {
    return _handleRequest(() async {
      final response = await _dio.get(
        ApiEndpoints.notificationsAdminByUser(userId),
      );
      return (response.data as List)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> createNotification({
    required int userId,
    required String title,
    required String description,
    required String urgency,
    String? source,
  }) async {
    return _handleRequest(() async {
      await _dio.post(
        ApiEndpoints.notificationsAdminCreate,
        data: {
          'userId': userId,
          'title': title,
          'description': description,
          'urgency': urgency,
          if (source != null && source.trim().isNotEmpty)
            'source': source.trim(),
        },
      );
    });
  }

  Future<void> markRead(int notificationId) async {
    return _handleRequest(() async {
      await _dio.patch(ApiEndpoints.notificationsMarkRead(notificationId));
    });
  }

  Future<String> markAllRead() async {
    return _handleRequest(() async {
      final response = await _dio.patch(ApiEndpoints.notificationsMarkAllRead);
      if (response.data is String) return response.data as String;
      if (response.data is Map && response.data['message'] != null) {
        return response.data['message'].toString();
      }
      return 'Todas las notificaciones se marcaron como leídas';
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
