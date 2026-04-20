import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/inventory_metrics_models.dart';

class InventoryMetricsRemoteDatasource {
  final Dio _dio;

  InventoryMetricsRemoteDatasource(this._dio);

  Future<List<TopSellingSpareMetric>> getTopSelling({int limit = 10}) async {
    if (limit <= 0) {
      throw const ServerException(
        message: 'El parámetro limit debe ser mayor a cero',
        statusCode: 400,
      );
    }

    return _handleRequest(() async {
      final response = await _dio.get(
        ApiEndpoints.adminInventoryTopSelling,
        queryParameters: {'limit': limit},
      );
      return (response.data as List)
          .map((e) => TopSellingSpareMetric.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<InventoryProfitMetric> getProfit({
    required String startDate,
    required String endDate,
  }) async {
    final parsedStart = DateTime.tryParse(startDate);
    final parsedEnd = DateTime.tryParse(endDate);
    if (parsedStart == null || parsedEnd == null) {
      throw const ServerException(
        message: 'startDate y endDate deben tener formato YYYY-MM-DD',
        statusCode: 400,
      );
    }
    if (parsedStart.isAfter(parsedEnd)) {
      throw const ServerException(
        message: 'startDate no puede ser mayor que endDate',
        statusCode: 400,
      );
    }

    return _handleRequest(() async {
      final response = await _dio.get(
        ApiEndpoints.adminInventoryProfit,
        queryParameters: {'startDate': startDate, 'endDate': endDate},
      );
      return InventoryProfitMetric.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }

  Future<List<StagnantSpareMetric>> getStagnant({
    int daysWithoutSales = 60,
  }) async {
    if (daysWithoutSales <= 0) {
      throw const ServerException(
        message: 'daysWithoutSales debe ser mayor a cero',
        statusCode: 400,
      );
    }

    return _handleRequest(() async {
      final response = await _dio.get(
        ApiEndpoints.adminInventoryStagnant,
        queryParameters: {'daysWithoutSales': daysWithoutSales},
      );
      return (response.data as List)
          .map((e) => StagnantSpareMetric.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<BelowThresholdPercentageMetric> getBelowThresholdPercentage() async {
    return _handleRequest(() async {
      final response = await _dio.get(
        ApiEndpoints.adminInventoryBelowThresholdPercentage,
      );
      return BelowThresholdPercentageMetric.fromJson(
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
