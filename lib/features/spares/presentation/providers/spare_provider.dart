import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/spare_remote_datasource.dart';
import '../../data/models/spare_model.dart';

final spareDatasourceProvider = Provider<SpareRemoteDatasource>((ref) {
  return SpareRemoteDatasource(ref.watch(dioClientProvider));
});

class SpareFilterState {
  final String name;
  final String savCode;

  const SpareFilterState({this.name = '', this.savCode = ''});

  SpareFilterState copyWith({String? name, String? savCode}) {
    return SpareFilterState(
      name: name ?? this.name,
      savCode: savCode ?? this.savCode,
    );
  }
}

final spareFilterProvider = StateProvider<SpareFilterState>((_) {
  return const SpareFilterState();
});

class SpareNotifier extends StateNotifier<AsyncValue<List<SpareModel>>> {
  final Ref _ref;

  SpareNotifier(this._ref) : super(const AsyncLoading()) {
    load();
  }

  Future<void> load({bool belowThresholdOnly = false}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ds = _ref.read(spareDatasourceProvider);
      if (belowThresholdOnly) {
        return ds.getBelowThresholdSpares();
      }
      final filter = _ref.read(spareFilterProvider);
      return ds.getSpares(name: filter.name, savCode: filter.savCode);
    });
  }

  Future<void> setFilter({String? name, String? savCode}) async {
    final current = _ref.read(spareFilterProvider);
    _ref.read(spareFilterProvider.notifier).state = current.copyWith(
      name: name,
      savCode: savCode,
    );
    await load();
  }

  Future<void> createSpare({
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
    final ds = _ref.read(spareDatasourceProvider);
    await ds.createSpare(
      name: name,
      savCode: savCode,
      spareCode: spareCode,
      supplier: supplier,
      compatibleMotorcycles: compatibleMotorcycles,
      quantity: quantity,
      purchasePriceWithVat: purchasePriceWithVat,
      isOil: isOil,
      warehouseLocation: warehouseLocation,
      stockThreshold: stockThreshold,
    );
    await load();
  }

  Future<void> updateSpare({
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
    final ds = _ref.read(spareDatasourceProvider);
    await ds.updateSpare(
      id: id,
      name: name,
      savCode: savCode,
      spareCode: spareCode,
      supplier: supplier,
      compatibleMotorcycles: compatibleMotorcycles,
      quantity: quantity,
      purchasePriceWithVat: purchasePriceWithVat,
      isOil: isOil,
      warehouseLocation: warehouseLocation,
      stockThreshold: stockThreshold,
    );
    await load();
  }

  Future<void> updatePurchasePrice({
    required int id,
    required double purchasePriceWithVat,
  }) async {
    final ds = _ref.read(spareDatasourceProvider);
    await ds.updatePurchasePrice(
      id: id,
      purchasePriceWithVat: purchasePriceWithVat,
    );
    await load();
  }

  Future<void> deleteSpare(int id) async {
    final ds = _ref.read(spareDatasourceProvider);
    await ds.deleteSpare(id);
    await load();
  }

  Future<String> notifyRestock(int id) async {
    final ds = _ref.read(spareDatasourceProvider);
    return ds.notifyRestock(id);
  }
}

final spareNotifierProvider =
    StateNotifierProvider<SpareNotifier, AsyncValue<List<SpareModel>>>((ref) {
      return SpareNotifier(ref);
    });
