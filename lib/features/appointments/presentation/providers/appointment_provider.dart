import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/appointment_remote_datasource.dart';
import '../../data/repositories/appointment_repository_impl.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/repositories/appointment_repository.dart';

part 'appointment_provider.g.dart';

/// Provides the [AppointmentRepository] instance.
@riverpod
AppointmentRepository appointmentRepository(AppointmentRepositoryRef ref) {
  final dio = ref.watch(dioClientProvider);
  return AppointmentRepositoryImpl(AppointmentRemoteDatasource(dio));
}

/// Manages the list of user appointments.
@riverpod
class AppointmentListNotifier extends _$AppointmentListNotifier {
  @override
  Future<List<AppointmentEntity>> build() async {
    final repo = ref.watch(appointmentRepositoryProvider);
    final result = await repo.getMyAppointments();
    return result.fold(
      (failure) => throw Exception(failure.toString()),
      (appointments) => appointments,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(appointmentRepositoryProvider);
      final result = await repo.getMyAppointments();
      return result.fold(
        (failure) => throw Exception(failure.toString()),
        (appointments) => appointments,
      );
    });
  }

  Future<AppointmentEntity> createAppointment({
    required int vehicleId,
    required String appointmentType,
    required String appointmentDate,
    required String startTime,
    required int currentMileage,
    List<String>? clientNotes,
  }) async {
    final repo = ref.read(appointmentRepositoryProvider);
    final result = await repo.createAppointment(
      vehicleId: vehicleId,
      appointmentType: appointmentType,
      appointmentDate: appointmentDate,
      startTime: startTime,
      currentMileage: currentMileage,
      clientNotes: clientNotes,
    );
    return result.fold(
      (failure) => throw Exception(failure.toString()),
      (appointment) {
        // Add to list
        final current = state.valueOrNull ?? [];
        state = AsyncData([appointment, ...current]);
        return appointment;
      },
    );
  }

  Future<void> cancelAppointment(int id) async {
    final repo = ref.read(appointmentRepositoryProvider);
    final result = await repo.cancelAppointment(id);
    result.fold(
      (failure) => throw Exception(failure.toString()),
      (updated) {
        final current = state.valueOrNull ?? [];
        state = AsyncData(
          current.map((a) => a.id == id ? updated : a).toList(),
        );
      },
    );
  }
}

/// Provider for available slots (date + type → slots).
@riverpod
class AvailableSlotsNotifier extends _$AvailableSlotsNotifier {
  @override
  Future<AvailableSlotsEntity?> build() async => null;

  Future<void> fetchSlots({
    required String date,
    required String type,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(appointmentRepositoryProvider);
      final result = await repo.getAvailableSlots(date: date, type: type);
      return result.fold(
        (failure) => throw Exception(failure.toString()),
        (slots) => slots,
      );
    });
  }

  void clear() {
    state = const AsyncData(null);
  }
}

/// Provider for plate restriction check.
@riverpod
class PlateRestrictionNotifier extends _$PlateRestrictionNotifier {
  @override
  Future<PlateRestrictionEntity?> build() async => null;

  Future<PlateRestrictionEntity?> check({
    required int vehicleId,
    required String date,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(appointmentRepositoryProvider);
    final result = await repo.checkPlateRestriction(
      vehicleId: vehicleId,
      date: date,
    );
    final entity = result.fold(
      (failure) {
        state = AsyncError(failure.toString(), StackTrace.current);
        return null;
      },
      (restriction) {
        state = AsyncData(restriction);
        return restriction;
      },
    );
    return entity;
  }
}
