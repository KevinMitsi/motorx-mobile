import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/notification_remote_datasource.dart';
import '../../data/models/notification_model.dart';

final notificationDatasourceProvider = Provider<NotificationRemoteDatasource>((
  ref,
) {
  return NotificationRemoteDatasource(ref.watch(dioClientProvider));
});

class NotificationState {
  final List<NotificationModel> notifications;
  final bool onlyUnread;
  final bool isLoading;
  final String? error;

  const NotificationState({
    this.notifications = const [],
    this.onlyUnread = false,
    this.isLoading = false,
    this.error,
  });

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? onlyUnread,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      onlyUnread: onlyUnread ?? this.onlyUnread,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  final Ref _ref;

  NotificationNotifier(this._ref) : super(const NotificationState()) {
    load();
  }

  Future<void> load({bool? onlyUnread}) async {
    final selectedOnlyUnread = onlyUnread ?? state.onlyUnread;
    state = state.copyWith(
      isLoading: true,
      onlyUnread: selectedOnlyUnread,
      clearError: true,
    );

    try {
      final ds = _ref.read(notificationDatasourceProvider);
      final data = await ds.getMyNotifications(onlyUnread: selectedOnlyUnread);
      state = state.copyWith(isLoading: false, notifications: data);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> markRead(int id) async {
    final ds = _ref.read(notificationDatasourceProvider);
    await ds.markRead(id);
    await load();
  }

  Future<String> markAllRead() async {
    final ds = _ref.read(notificationDatasourceProvider);
    final message = await ds.markAllRead();
    await load();
    return message;
  }

  Future<void> createNotification({
    required int userId,
    required String title,
    required String description,
    required String urgency,
    String? source,
  }) async {
    final ds = _ref.read(notificationDatasourceProvider);
    await ds.createNotification(
      userId: userId,
      title: title,
      description: description,
      urgency: urgency,
      source: source,
    );
    await load();
  }
}

final notificationNotifierProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
      return NotificationNotifier(ref);
    });
