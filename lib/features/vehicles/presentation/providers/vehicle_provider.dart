import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/vehicle_remote_datasource.dart';
import '../../data/repositories/vehicle_repository_impl.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../../domain/repositories/vehicle_repository.dart';

part 'vehicle_provider.g.dart';

/// Provider for the vehicle repository.
final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  final dio = ref.read(dioClientProvider);
  final datasource = VehicleRemoteDatasource(dio);
  return VehicleRepositoryImpl(datasource);
});

/// Notifier for user's vehicle list.
@riverpod
class VehicleListNotifier extends _$VehicleListNotifier {
  @override
  FutureOr<List<VehicleEntity>> build() async {
    final repo = ref.read(vehicleRepositoryProvider);
    final result = await repo.getMyVehicles();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (vehicles) => vehicles,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final repo = ref.read(vehicleRepositoryProvider);
    final result = await repo.getMyVehicles();
    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (vehicles) => AsyncData(vehicles),
    );
  }

  Future<void> createVehicle({
    required String brand,
    required String model,
    required int yearOfManufacture,
    required String licensePlate,
    required int cylinderCapacity,
    required String chassisNumber,
  }) async {
    final repo = ref.read(vehicleRepositoryProvider);
    final result = await repo.createVehicle(
      brand: brand,
      model: model,
      yearOfManufacture: yearOfManufacture,
      licensePlate: licensePlate,
      cylinderCapacity: cylinderCapacity,
      chassisNumber: chassisNumber,
    );
    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => refresh(),
    );
  }

  Future<void> updateVehicle({
    required int id,
    required String brand,
    required String model,
    required int cylinderCapacity,
  }) async {
    final repo = ref.read(vehicleRepositoryProvider);
    final result = await repo.updateVehicle(
      id: id,
      brand: brand,
      model: model,
      cylinderCapacity: cylinderCapacity,
    );
    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => refresh(),
    );
  }

  Future<void> deleteVehicle(int id) async {
    final repo = ref.read(vehicleRepositoryProvider);
    final result = await repo.deleteVehicle(id);
    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => refresh(),
    );
  }
}
