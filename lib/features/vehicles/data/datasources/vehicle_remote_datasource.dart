import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/vehicle_model.dart';

/// Remote data source for vehicle endpoints.
class VehicleRemoteDatasource {
  final Dio _dio;

  VehicleRemoteDatasource(this._dio);

  Future<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message']?.toString() ??
            'Error del servidor',
        statusCode: e.response?.statusCode ?? 500,
        details: e.response?.data is Map<String, dynamic>
            ? e.response?.data as Map<String, dynamic>
            : null,
      );
    }
  }

  Future<List<VehicleModel>> getMyVehicles() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.userVehicles);
      final data = response.data as List;
      return data
          .map((e) => VehicleModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<VehicleModel> getVehicle(int id) async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.userVehicleDetail(id));
      return VehicleModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  Future<VehicleModel> createVehicle({
    required String brand,
    required String model,
    required int yearOfManufacture,
    required String licensePlate,
    required int cylinderCapacity,
    required String chassisNumber,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.userVehicles,
        data: {
          'brand': brand,
          'model': model,
          'yearOfManufacture': yearOfManufacture,
          'licensePlate': licensePlate,
          'cylinderCapacity': cylinderCapacity,
          'chassisNumber': chassisNumber,
        },
      );
      return VehicleModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  Future<VehicleModel> updateVehicle({
    required int id,
    required String brand,
    required String model,
    required int cylinderCapacity,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.put(
        ApiEndpoints.userVehicleDetail(id),
        data: {
          'brand': brand,
          'model': model,
          'cylinderCapacity': cylinderCapacity,
        },
      );
      return VehicleModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  Future<void> deleteVehicle(int id) async {
    return _handleRequest(() async {
      await _dio.delete(ApiEndpoints.userVehicleDetail(id));
    });
  }
}
