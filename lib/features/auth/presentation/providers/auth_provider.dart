import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_provider.g.dart';

/// Provider for the auth repository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(dioClientProvider);
  final storage = ref.read(secureStorageProvider);
  final datasource = AuthRemoteDatasource(dio);
  return AuthRepositoryImpl(datasource, storage);
});

/// Main auth state notifier.
/// Holds the current [AuthEntity] or null if not authenticated.
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<AuthEntity?> build() async {
    // Try to load cached auth on startup
    final repo = ref.read(authRepositoryProvider);
    return repo.getCachedAuth();
  }

  /// Login flow — may return AuthEntity (ADMIN) or trigger 2FA.
  Future<dynamic> login(String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.login(email: email, password: password);
    return result.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
        throw failure;
      },
      (data) {
        if (data is AuthEntity) {
          state = AsyncData(data);
          return data;
        }
        // 2FA needed — keep state as not logged in
        state = const AsyncData(null);
        return data;
      },
    );
  }

  /// Verify 2FA code after login.
  Future<void> verify2fa(String email, String code) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.verify2fa(email: email, code: code);
    result.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
      },
      (auth) {
        state = AsyncData(auth);
      },
    );
  }

  /// Register a new user.
  Future<void> register({
    required String name,
    required String dni,
    required String email,
    required String password,
    required String phone,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.register(
      name: name,
      dni: dni,
      email: email,
      password: password,
      phone: phone,
    );
    result.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
      },
      (auth) {
        state = AsyncData(auth);
      },
    );
  }

  /// Logout — clear state and cached tokens.
  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.logout();
    state = const AsyncData(null);
  }
}
