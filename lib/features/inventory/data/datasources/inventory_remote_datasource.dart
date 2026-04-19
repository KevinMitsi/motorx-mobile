import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/inventory_models.dart';

class InventoryRemoteDatasource {
  final Dio _dio;

  InventoryRemoteDatasource(this._dio);

  Future<List<PurchaseTransactionModel>> getPurchases() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.inventoryPurchases);
      return (response.data as List)
          .map(
            (e) => PurchaseTransactionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    });
  }

  Future<PurchaseTransactionModel> createPurchase({
    required List<Map<String, dynamic>> items,
    String? supplier,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.inventoryPurchases,
        data: {
          'items': items,
          if (supplier?.trim().isNotEmpty ?? false)
            'supplier': supplier!.trim(),
        },
      );
      return PurchaseTransactionModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }

  Future<PurchaseTransactionModel> getPurchaseDetail(int id) async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.inventoryPurchaseDetail(id));
      return PurchaseTransactionModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }

  Future<List<SaleTransactionModel>> getSales() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.inventorySales);
      return (response.data as List)
          .map((e) => SaleTransactionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<SaleTransactionModel> createSale({
    required List<Map<String, dynamic>> items,
    int? appointmentId,
    String? notes,
  }) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.inventorySales,
        data: {
          'items': items,
          if (appointmentId != null) 'appointmentId': appointmentId,
          if (notes?.trim().isNotEmpty ?? false) 'notes': notes!.trim(),
        },
      );
      return SaleTransactionModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }

  Future<SaleTransactionModel> getSaleDetail(int id) async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.inventorySaleDetail(id));
      return SaleTransactionModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }

  Future<DailySalesSummaryModel> getTodaySalesSummary() async {
    return _handleRequest(() async {
      final response = await _dio.get(ApiEndpoints.inventorySalesToday);
      return DailySalesSummaryModel.fromJson(
        response.data as Map<String, dynamic>,
      );
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
