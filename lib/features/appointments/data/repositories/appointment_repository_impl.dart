import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../datasources/appointment_remote_datasource.dart';
import '../models/appointment_model.dart';

/// Concrete implementation of [AppointmentRepository].
class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDatasource _datasource;

  AppointmentRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, AvailableSlotsEntity>> getAvailableSlots({
    required String date,
    required String type,
  }) async {
    try {
      final model = await _datasource.getAvailableSlots(date: date, type: type);
      return Right(_mapSlotsToEntity(model));
    } on ServerException catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, PlateRestrictionEntity>> checkPlateRestriction({
    required int vehicleId,
    required String date,
  }) async {
    try {
      final model = await _datasource.checkPlateRestriction(
        vehicleId: vehicleId,
        date: date,
      );
      return Right(_mapRestrictionToEntity(model));
    } on ServerException catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, ReworkInfoEntity>> getReworkInfo() async {
    try {
      final model = await _datasource.getReworkInfo();
      return Right(
        ReworkInfoEntity(
          message: model.message,
          whatsappLink: model.whatsappLink,
          phoneNumber: model.phoneNumber,
          businessHours: model.businessHours,
        ),
      );
    } on ServerException catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> createAppointment({
    required int vehicleId,
    required String appointmentType,
    required String appointmentDate,
    required String startTime,
    required int currentMileage,
    List<String>? clientNotes,
  }) async {
    try {
      final model = await _datasource.createAppointment(
        vehicleId: vehicleId,
        appointmentType: appointmentType,
        appointmentDate: appointmentDate,
        startTime: startTime,
        currentMileage: currentMileage,
        clientNotes: clientNotes,
      );
      return Right(_mapToEntity(model));
    } on ServerException catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getMyAppointments() async {
    try {
      final models = await _datasource.getMyAppointments();
      return Right(models.map(_mapToEntity).toList());
    } on ServerException catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> getAppointmentDetail(
    int id,
  ) async {
    try {
      final model = await _datasource.getAppointmentDetail(id);
      return Right(_mapToEntity(model));
    } on ServerException catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getVehicleAppointments(
    int vehicleId,
  ) async {
    try {
      final models = await _datasource.getVehicleAppointments(vehicleId);
      return Right(models.map(_mapToEntity).toList());
    } on ServerException catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> cancelAppointment(int id) async {
    try {
      final model = await _datasource.cancelAppointment(id);
      return Right(_mapToEntity(model));
    } on ServerException catch (e) {
      return Left(_mapException(e));
    }
  }

  // ── Mappers ───────────────────────────────────────────────

  AppointmentEntity _mapToEntity(AppointmentModel m) => AppointmentEntity(
    id: m.id,
    appointmentType: m.appointmentType,
    status: m.status,
    appointmentDate: m.appointmentDate,
    startTime: m.startTime,
    endTime: m.endTime,
    vehicleId: m.vehicleId,
    vehiclePlate: m.vehiclePlate,
    vehicleBrand: m.vehicleBrand,
    vehicleModel: m.vehicleModel,
    clientId: m.clientId,
    clientFullName: m.clientFullName,
    clientEmail: m.clientEmail,
    technicianId: m.technicianId,
    technicianFullName: m.technicianFullName,
    currentMileage: m.currentMileage,
    clientNotes: m.clientNotes,
    adminNotes: m.adminNotes,
    verificationCode: m.verificationCode,
    verificationCodeCreatedAt: m.verificationCodeCreatedAt,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
  );

  AvailableSlotsEntity _mapSlotsToEntity(AvailableSlotsModel m) =>
      AvailableSlotsEntity(
        date: m.date,
        appointmentType: m.appointmentType,
        availableSlots: m.availableSlots
            .map(
              (s) => AvailableSlotEntity(
                startTime: s.startTime,
                endTime: s.endTime,
                availableTechnicians: s.availableTechnicians,
              ),
            )
            .toList(),
      );

  PlateRestrictionEntity _mapRestrictionToEntity(PlateRestrictionModel m) =>
      PlateRestrictionEntity(
        vehiclePlate: m.vehiclePlate,
        restrictedDate: m.restrictedDate,
        message: m.message,
        urgentContactMessage: m.urgentContactMessage,
        phoneNumber: m.phoneNumber,
        businessHours: m.businessHours,
      );

  Failure _mapException(ServerException e) => switch (e.statusCode) {
    401 => const UnauthorizedFailure('Sesión expirada'),
    403 => const ForbiddenFailure('No tienes permisos para esta operación'),
    404 => NotFoundFailure(e.message),
    409 => ConflictFailure(e.message),
    422 => ValidationFailure(
      e.message,
      fieldErrors: e.details is Map<String, dynamic>
          ? (e.details as Map<String, dynamic>).map(
              (k, v) => MapEntry(k, v.toString()),
            )
          : null,
    ),
    _ => ServerFailure(e.message),
  };
}
