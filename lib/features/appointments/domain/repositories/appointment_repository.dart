import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/appointment_entity.dart';

/// Abstract contract for the appointments domain.
abstract class AppointmentRepository {
  /// Get available time slots for a given date and type.
  Future<Either<Failure, AvailableSlotsEntity>> getAvailableSlots({
    required String date,
    required String type,
  });

  /// Check plate restriction (pico y placa) for a vehicle on a date.
  Future<Either<Failure, PlateRestrictionEntity>> checkPlateRestriction({
    required int vehicleId,
    required String date,
  });

  /// Get rework contact info.
  Future<Either<Failure, ReworkInfoEntity>> getReworkInfo();

  /// Create a new appointment.
  Future<Either<Failure, AppointmentEntity>> createAppointment({
    required int vehicleId,
    required String appointmentType,
    required String appointmentDate,
    required String startTime,
    required int currentMileage,
    List<String>? clientNotes,
  });

  /// Get all of current user's appointments.
  Future<Either<Failure, List<AppointmentEntity>>> getMyAppointments();

  /// Get a specific appointment detail.
  Future<Either<Failure, AppointmentEntity>> getAppointmentDetail(int id);

  /// Get appointments for a specific vehicle.
  Future<Either<Failure, List<AppointmentEntity>>> getVehicleAppointments(
      int vehicleId);

  /// Cancel an appointment.
  Future<Either<Failure, AppointmentEntity>> cancelAppointment(int id);
}
