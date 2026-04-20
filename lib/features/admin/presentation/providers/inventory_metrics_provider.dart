import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/models/inventory_metrics_models.dart';
import '../../data/datasources/inventory_metrics_remote_datasource.dart';

final inventoryMetricsDatasourceProvider =
    Provider<InventoryMetricsRemoteDatasource>((ref) {
      return InventoryMetricsRemoteDatasource(ref.watch(dioClientProvider));
    });

class InventoryMetricsState {
  final bool isLoading;
  final String? error;
  final List<TopSellingSpareMetric> topSelling;
  final InventoryProfitMetric? profit;
  final List<StagnantSpareMetric> stagnant;
  final BelowThresholdPercentageMetric? belowThreshold;

  const InventoryMetricsState({
    this.isLoading = false,
    this.error,
    this.topSelling = const [],
    this.profit,
    this.stagnant = const [],
    this.belowThreshold,
  });

  InventoryMetricsState copyWith({
    bool? isLoading,
    String? error,
    List<TopSellingSpareMetric>? topSelling,
    InventoryProfitMetric? profit,
    List<StagnantSpareMetric>? stagnant,
    BelowThresholdPercentageMetric? belowThreshold,
    bool clearError = false,
  }) {
    return InventoryMetricsState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
      topSelling: topSelling ?? this.topSelling,
      profit: profit ?? this.profit,
      stagnant: stagnant ?? this.stagnant,
      belowThreshold: belowThreshold ?? this.belowThreshold,
    );
  }
}

class InventoryMetricsNotifier extends StateNotifier<InventoryMetricsState> {
  final Ref _ref;

  InventoryMetricsNotifier(this._ref) : super(const InventoryMetricsState()) {
    load();
  }

  Future<void> load({
    int limit = 10,
    int daysWithoutSales = 60,
    String? startDate,
    String? endDate,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final now = DateTime.now();
    final defaultStart = DateTime(now.year, now.month, 1);
    final start =
        startDate ??
        '${defaultStart.year.toString().padLeft(4, '0')}-${defaultStart.month.toString().padLeft(2, '0')}-${defaultStart.day.toString().padLeft(2, '0')}';
    final end =
        endDate ??
        '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    try {
      final ds = _ref.read(inventoryMetricsDatasourceProvider);
      final results = await Future.wait([
        ds.getTopSelling(limit: limit),
        ds.getProfit(startDate: start, endDate: end),
        ds.getStagnant(daysWithoutSales: daysWithoutSales),
        ds.getBelowThresholdPercentage(),
      ]);

      state = state.copyWith(
        isLoading: false,
        topSelling: results[0] as List<TopSellingSpareMetric>,
        profit: results[1] as InventoryProfitMetric,
        stagnant: results[2] as List<StagnantSpareMetric>,
        belowThreshold: results[3] as BelowThresholdPercentageMetric,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final inventoryMetricsNotifierProvider =
    StateNotifierProvider<InventoryMetricsNotifier, InventoryMetricsState>((
      ref,
    ) {
      return InventoryMetricsNotifier(ref);
    });
