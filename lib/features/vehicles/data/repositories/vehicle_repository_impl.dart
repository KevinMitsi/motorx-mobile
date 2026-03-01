import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../datasources/vehicle_remote_datasource.dart';
import '../models/vehicle_model.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDatasource _remoteDatasource;

  VehicleRepositoryImpl(this._remoteDatasource);

  VehicleEntity _map(VehicleModel m) => VehicleEntity(
        id: m.id,
        brand: m.brand,
        model: m.model,
        yearOfManufacture: m.yearOfManufacture,
        licensePlate: m.licensePlate,
        cylinderCapacity: m.cylinderCapacity,
        chassisNumber: m.chassisNumber,
        ownerId: m.ownerId,
        ownerName: m.ownerName,
        ownerEmail: m.ownerEmail,
        createdAt: m.createdAt,
        updatedAt: m.updatedAt,
      );

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
  Future<Either<Failure, List<VehicleEntity>>> getMyVehicles() async {
    try {
      final models = await _remoteDatasource.getMyVehicles();
      return Right(models.map(_map).toList());
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, VehicleEntity>> getVehicle(int id) async {
    try {
      final model = await _remoteDatasource.getVehicle(id);
      return Right(_map(model));
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, VehicleEntity>> createVehicle({
    required String brand,
    required String model,
    required int yearOfManufacture,
    required String licensePlate,
    required int cylinderCapacity,
    required String chassisNumber,
  }) async {
    try {
      final result = await _remoteDatasource.createVehicle(
        brand: brand,
        model: model,
        yearOfManufacture: yearOfManufacture,
        licensePlate: licensePlate,
        cylinderCapacity: cylinderCapacity,
        chassisNumber: chassisNumber,
      );
      return Right(_map(result));
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, VehicleEntity>> updateVehicle({
    required int id,
    required String brand,
    required String model,
    required int cylinderCapacity,
  }) async {
    try {
      final result = await _remoteDatasource.updateVehicle(
        id: id,
        brand: brand,
        model: model,
        cylinderCapacity: cylinderCapacity,
      );
      return Right(_map(result));
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteVehicle(int id) async {
    try {
      await _remoteDatasource.deleteVehicle(id);
      return const Right(null);
    } catch (e) {
      return Left(_mapException(e));
    }
  }
}
