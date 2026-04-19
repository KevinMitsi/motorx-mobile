import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/spare_model.dart';

class SpareRemoteDatasource {
  final Dio _dio;

  SpareRemoteDatasource(this._dio);

  Future<List<SpareModel>> getSpares({String? name, String? savCode}) async {
    return _handleRequest(() async {
      final query = <String, dynamic>{
        if (name != null && name.trim().isNotEmpty) 'name': name.trim(),
        if (savCode != null && savCode.trim().isNotEmpty)
          'savCode': savCode.trim(),
      };
      final response = await _dio.get(
        ApiEndpoints.spares,
        queryParameters: query.isEmpty ? null : query,
      );
      return (response.data as List)
          .map((e) => SpareModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<SpareModel> getSpareById(int id) async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.spareDetail(id));
      return SpareModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  Future<SpareModel> createSpare({
    required String name,
    required String savCode,
    required String spareCode,
    required String supplier,
    required List<String> compatibleMotorcycles,
    required int quantity,
    required double purchasePriceWithVat,
    required bool isOil,
    required String warehouseLocation,
    required int stockThreshold,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.spares,
        data: {
          'name': name,
          'savCode': savCode,
          'spareCode': spareCode,
          'supplier': supplier,
          'compatibleMotorcycles': compatibleMotorcycles,
          'quantity': quantity,
          'purchasePriceWithVat': purchasePriceWithVat,
          'isOil': isOil,
          'warehouseLocation': warehouseLocation,
          'stockThreshold': stockThreshold,
        },
      );
      return SpareModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  Future<SpareModel> updateSpare({
    required int id,
    required String name,
    required String savCode,
    required String spareCode,
    required String supplier,
    required List<String> compatibleMotorcycles,
    required int quantity,
    required double purchasePriceWithVat,
    required bool isOil,
    required String warehouseLocation,
    required int stockThreshold,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.put(
        ApiEndpoints.spareDetail(id),
        data: {
          'name': name,
          'savCode': savCode,
          'spareCode': spareCode,
          'supplier': supplier,
          'compatibleMotorcycles': compatibleMotorcycles,
          'quantity': quantity,
          'purchasePriceWithVat': purchasePriceWithVat,
          'isOil': isOil,
          'warehouseLocation': warehouseLocation,
          'stockThreshold': stockThreshold,
        },
      );
      return SpareModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  Future<SpareModel> updatePurchasePrice({
    required int id,
    required double purchasePriceWithVat,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.patch(
        ApiEndpoints.sparePurchasePrice(id),
        data: {'purchasePriceWithVat': purchasePriceWithVat},
      );
      return SpareModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  Future<void> deleteSpare(int id) async {
    return _handleRequest(() async {
      await _dio.delete(ApiEndpoints.spareDetail(id));
    });
  }

  Future<List<SpareModel>> getBelowThresholdSpares() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.sparesBelowThreshold);
      return (response.data as List)
          .map((e) => SpareModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<String> notifyRestock(int id) async {
    return _handleRequest(() async {
      final response = await _dio.post(ApiEndpoints.spareNotifyRestock(id));
      if (response.data is String) return response.data as String;
      if (response.data is Map && response.data['message'] != null) {
        return response.data['message'].toString();
      }
      return 'Notificación de surtido enviada';
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
