import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/vehicle_entity.dart';

/// Abstract repository contract for vehicle operations.
abstract class VehicleRepository {
  Future<Either<Failure, List<VehicleEntity>>> getMyVehicles();
  Future<Either<Failure, VehicleEntity>> getVehicle(int id);
  Future<Either<Failure, VehicleEntity>> createVehicle({
    required String brand,
    required String model,
    required int yearOfManufacture,
    required String licensePlate,
    required int cylinderCapacity,
    required String chassisNumber,
  });
  Future<Either<Failure, VehicleEntity>> updateVehicle({
    required int id,
    required String brand,
    required String model,
    required int cylinderCapacity,
  });
  Future<Either<Failure, void>> deleteVehicle(int id);
}
