import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/inventory_remote_datasource.dart';
import '../../data/models/inventory_models.dart';

final inventoryDatasourceProvider = Provider<InventoryRemoteDatasource>((ref) {
  return InventoryRemoteDatasource(ref.watch(dioClientProvider));
});

class InventoryState {
  final List<PurchaseTransactionModel> purchases;
  final List<SaleTransactionModel> sales;
  final DailySalesSummaryModel? todaySummary;
  final bool isLoading;
  final String? error;

  const InventoryState({
    this.purchases = const [],
    this.sales = const [],
    this.todaySummary,
    this.isLoading = false,
    this.error,
  });

  InventoryState copyWith({
    List<PurchaseTransactionModel>? purchases,
    List<SaleTransactionModel>? sales,
    DailySalesSummaryModel? todaySummary,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return InventoryState(
      purchases: purchases ?? this.purchases,
      sales: sales ?? this.sales,
      todaySummary: todaySummary ?? this.todaySummary,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class InventoryNotifier extends StateNotifier<InventoryState> {
  final Ref _ref;

  InventoryNotifier(this._ref) : super(const InventoryState()) {
    loadAll();
  }

  Future<void> loadAll() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final ds = _ref.read(inventoryDatasourceProvider);
      final results = await Future.wait([
        ds.getPurchases(),
        ds.getSales(),
        ds.getTodaySalesSummary(),
      ]);
      state = state.copyWith(
        isLoading: false,
        purchases: results[0] as List<PurchaseTransactionModel>,
        sales: results[1] as List<SaleTransactionModel>,
        todaySummary: results[2] as DailySalesSummaryModel,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createPurchase({
    required List<Map<String, dynamic>> items,
    required String supplier,
  }) async {
    try {
      final ds = _ref.read(inventoryDatasourceProvider);
      await ds.createPurchase(items: items, supplier: supplier);
      await loadAll();
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<void> createSale({
    required List<Map<String, dynamic>> items,
    int? appointmentId,
  }) async {
    try {
      final ds = _ref.read(inventoryDatasourceProvider);
      await ds.createSale(items: items, appointmentId: appointmentId);
      await loadAll();
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }
}

final inventoryNotifierProvider =
    StateNotifierProvider<InventoryNotifier, InventoryState>((ref) {
      return InventoryNotifier(ref);
    });
