import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_entity.dart';
import '../entities/user_entity.dart';

/// Abstract repository contract for authentication.
/// Domain layer — implemented by data layer.
abstract class AuthRepository {
  /// Login with email and password.
  /// Returns [AuthEntity] for ADMIN, or a message string for 2FA flow.
  Future<Either<Failure, dynamic>> login({
    required String email,
    required String password,
  });

  /// Verify 2FA code after login.
  Future<Either<Failure, AuthEntity>> verify2fa({
    required String email,
    required String code,
  });

  /// Register a new CLIENT user.
  Future<Either<Failure, AuthEntity>> register({
    required String name,
    required String dni,
    required String email,
    required String password,
    required String phone,
  });

  /// Get current authenticated user profile.
  Future<Either<Failure, UserEntity>> getMe();

  /// Logout (invalidate token).
  Future<Either<Failure, void>> logout();

  /// Request password reset code.
  Future<Either<Failure, String>> requestPasswordReset({
    required String email,
  });

  /// Reset password with token.
  Future<Either<Failure, String>> resetPassword({
    required String token,
    required String newPassword,
  });

  /// Refresh access token.
  Future<Either<Failure, AuthEntity>> refreshToken({
    required String refreshToken,
  });

  /// Get cached auth data (from secure storage).
  Future<AuthEntity?> getCachedAuth();

  /// Clear cached auth data.
  Future<void> clearCachedAuth();
}
