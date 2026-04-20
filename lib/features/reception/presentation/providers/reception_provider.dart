import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/reception_remote_datasource.dart';

final receptionDatasourceProvider = Provider<ReceptionRemoteDatasource>((ref) {
  return ReceptionRemoteDatasource(ref.watch(dioClientProvider));
});

class ReceptionState {
  final bool isLoading;
  final String? lastMessage;
  final String? error;

  const ReceptionState({this.isLoading = false, this.lastMessage, this.error});

  ReceptionState copyWith({
    bool? isLoading,
    String? lastMessage,
    String? error,
    bool clearError = false,
  }) {
    return ReceptionState(
      isLoading: isLoading ?? this.isLoading,
      lastMessage: lastMessage ?? this.lastMessage,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class ReceptionNotifier extends StateNotifier<ReceptionState> {
  final Ref _ref;

  ReceptionNotifier(this._ref) : super(const ReceptionState());

  Future<void> initiateReception(int appointmentId) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final ds = _ref.read(receptionDatasourceProvider);
      final message = await ds.initiateReception(appointmentId);
      state = state.copyWith(isLoading: false, lastMessage: message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> confirmReception({
    required String vehiclePlate,
    required String code,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final ds = _ref.read(receptionDatasourceProvider);
      final message = await ds.confirmReception(
        vehiclePlate: vehiclePlate,
        code: code,
      );
      state = state.copyWith(isLoading: false, lastMessage: message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }
}

final receptionNotifierProvider =
    StateNotifierProvider<ReceptionNotifier, ReceptionState>((ref) {
      return ReceptionNotifier(ref);
    });
