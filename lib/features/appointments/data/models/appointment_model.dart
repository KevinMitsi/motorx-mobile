import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_model.freezed.dart';
part 'appointment_model.g.dart';

/// Model matching `AppointmentResponseDTO` from the API.
@freezed
class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    required int id,
    required String appointmentType,
    required String status,
    required String appointmentDate,
    required String startTime,
    required String endTime,
    required int vehicleId,
    required String vehiclePlate,
    required String vehicleBrand,
    required String vehicleModel,
    required int clientId,
    required String clientFullName,
    required String clientEmail,
    int? technicianId,
    String? technicianFullName,
    required int currentMileage,
    String? clientNotes,
    String? adminNotes,
    required String createdAt,
    String? updatedAt,
  }) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);
}

/// Model matching `AvailableSlotsResponseDTO`.
@freezed
class AvailableSlotsModel with _$AvailableSlotsModel {
  const factory AvailableSlotsModel({
    required String date,
    required String appointmentType,
    required List<AvailableSlotModel> availableSlots,
  }) = _AvailableSlotsModel;

  factory AvailableSlotsModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotsModelFromJson(json);
}

/// Single available time slot.
@freezed
class AvailableSlotModel with _$AvailableSlotModel {
  const factory AvailableSlotModel({
    required String startTime,
    required String endTime,
    required int availableTechnicians,
  }) = _AvailableSlotModel;

  factory AvailableSlotModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotModelFromJson(json);
}

/// Model matching `LicensePlateRestrictionResponseDTO`.
@freezed
class PlateRestrictionModel with _$PlateRestrictionModel {
  const factory PlateRestrictionModel({
    required String vehiclePlate,
    required String restrictedDate,
    required String message,
    String? urgentContactMessage,
    String? phoneNumber,
    String? businessHours,
  }) = _PlateRestrictionModel;

  factory PlateRestrictionModel.fromJson(Map<String, dynamic> json) =>
      _$PlateRestrictionModelFromJson(json);
}

/// Model matching `ReworkRedirectResponseDTO`.
@freezed
class ReworkInfoModel with _$ReworkInfoModel {
  const factory ReworkInfoModel({
    required String message,
    required String whatsappLink,
    required String phoneNumber,
    required String businessHours,
  }) = _ReworkInfoModel;

  factory ReworkInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ReworkInfoModelFromJson(json);
}
