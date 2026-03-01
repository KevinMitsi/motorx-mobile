import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_response_model.dart';

/// Implementation of [AuthRepository].
/// Bridges the data layer with the domain layer.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final FlutterSecureStorage _secureStorage;

  AuthRepositoryImpl(this._remoteDatasource, this._secureStorage);

  AuthEntity _mapModelToEntity(AuthResponseModel model) => AuthEntity(
        token: model.token,
        type: model.type,
        userId: model.userId,
        email: model.email,
        name: model.name,
        role: model.role,
      );

  Future<void> _cacheAuth(AuthResponseModel model) async {
    await _secureStorage.write(key: 'access_token', value: model.token);
    await _secureStorage.write(
        key: 'user_id', value: model.userId.toString());
    await _secureStorage.write(key: 'user_email', value: model.email);
    await _secureStorage.write(key: 'user_name', value: model.name);
    await _secureStorage.write(key: 'user_role', value: model.role);
  }

  Failure _mapException(Object e) {
    if (e is ServerException) {
      return switch (e.statusCode) {
        401 => UnauthorizedFailure(e.message),
        403 => ForbiddenFailure(e.message),
        404 => NotFoundFailure(e.message),
        409 => ConflictFailure(e.message),
        400 => ValidationFailure(e.message, fieldErrors: e.details),
        _ => ServerFailure(e.message, statusCode: e.statusCode),
      };
    }
    return ServerFailure(e.toString());
  }

  @override
  Future<Either<Failure, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _remoteDatasource.login(email: email, password: password);
      if (result is AuthResponseModel) {
        await _cacheAuth(result);
        return Right(_mapModelToEntity(result));
      }
      return Right(result);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> verify2fa({
    required String email,
    required String code,
  }) async {
    try {
      final result =
          await _remoteDatasource.verify2fa(email: email, code: code);
      await _cacheAuth(result);
      return Right(_mapModelToEntity(result));
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> register({
    required String name,
    required String dni,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final result = await _remoteDatasource.register(
        name: name,
        dni: dni,
        email: email,
        password: password,
        phone: phone,
      );
      await _cacheAuth(result);
      return Right(_mapModelToEntity(result));
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    try {
      final model = await _remoteDatasource.getMe();
      return Right(UserEntity(
        id: model.id,
        name: model.name,
        dni: model.dni,
        email: model.email,
        phone: model.phone,
        createdAt: model.createdAt,
        role: model.role,
        enabled: model.enabled,
        accountLocked: model.accountLocked,
        updatedAt: model.updatedAt,
      ));
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDatasource.logout();
      await clearCachedAuth();
      return const Right(null);
    } catch (e) {
      // Still clear local cache even if server call fails
      await clearCachedAuth();
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, String>> requestPasswordReset({
    required String email,
  }) async {
    try {
      final result =
          await _remoteDatasource.requestPasswordReset(email: email);
      return Right(result);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final result = await _remoteDatasource.resetPassword(
        token: token,
        newPassword: newPassword,
      );
      return Right(result);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final result =
          await _remoteDatasource.refreshToken(refreshToken: refreshToken);
      await _cacheAuth(result);
      return Right(_mapModelToEntity(result));
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<AuthEntity?> getCachedAuth() async {
    final token = await _secureStorage.read(key: 'access_token');
    final userId = await _secureStorage.read(key: 'user_id');
    final email = await _secureStorage.read(key: 'user_email');
    final name = await _secureStorage.read(key: 'user_name');
    final role = await _secureStorage.read(key: 'user_role');

    if (token != null && userId != null && email != null && name != null && role != null) {
      return AuthEntity(
        token: token,
        type: 'Bearer',
        userId: int.parse(userId),
        email: email,
        name: name,
        role: role,
      );
    }
    return null;
  }

  @override
  Future<void> clearCachedAuth() async {
    await _secureStorage.deleteAll();
  }
}
