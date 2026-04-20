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
    required String supplier,
  }) async {
    final normalizedSupplier = supplier.trim();
    if (normalizedSupplier.isEmpty) {
      throw const ServerException(
        message: 'El proveedor es obligatorio',
        statusCode: 400,
      );
    }
    final normalizedItems = _normalizePurchaseItems(items);

    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.inventoryPurchases,
        data: {'supplier': normalizedSupplier, 'items': normalizedItems},
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
  }) async {
    final normalizedItems = _normalizeSaleItems(items);

    return _handleRequest(() async {
      final response = await _dio.post(
        ApiEndpoints.inventorySales,
        data: {
          'items': normalizedItems,
          if (appointmentId != null) 'appointmentId': appointmentId,
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

  List<Map<String, dynamic>> _normalizePurchaseItems(
    List<Map<String, dynamic>> items,
  ) {
    if (items.isEmpty) {
      throw const ServerException(
        message: 'Debe incluir al menos un item',
        statusCode: 400,
      );
    }

    return items.map((item) {
      final spareId = (item['spareId'] as num?)?.toInt() ?? 0;
      final quantity = (item['quantity'] as num?)?.toInt() ?? 0;
      final priceRaw = item['purchasePriceWithVat'] ?? item['unitCost'];
      final purchasePriceWithVat = priceRaw is num
          ? priceRaw.toDouble()
          : double.tryParse(priceRaw?.toString() ?? '');

      if (spareId <= 0) {
        throw const ServerException(
          message: 'El ID del repuesto es obligatorio',
          statusCode: 400,
        );
      }
      if (quantity <= 0) {
        throw const ServerException(
          message: 'La cantidad debe ser mayor a cero',
          statusCode: 400,
        );
      }
      if (purchasePriceWithVat == null || purchasePriceWithVat < 0) {
        throw const ServerException(
          message: 'El precio de compra no puede ser negativo',
          statusCode: 400,
        );
      }

      return {
        'spareId': spareId,
        'quantity': quantity,
        'purchasePriceWithVat': purchasePriceWithVat,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _normalizeSaleItems(
    List<Map<String, dynamic>> items,
  ) {
    if (items.isEmpty) {
      throw const ServerException(
        message: 'Debe incluir al menos un item',
        statusCode: 400,
      );
    }

    return items.map((item) {
      final spareId = (item['spareId'] as num?)?.toInt() ?? 0;
      final quantity = (item['quantity'] as num?)?.toInt() ?? 0;

      if (spareId <= 0) {
        throw const ServerException(
          message: 'El ID del repuesto es obligatorio',
          statusCode: 400,
        );
      }
      if (quantity <= 0) {
        throw const ServerException(
          message: 'La cantidad debe ser mayor a cero',
          statusCode: 400,
        );
      }

      return {'spareId': spareId, 'quantity': quantity};
    }).toList();
  }
}
