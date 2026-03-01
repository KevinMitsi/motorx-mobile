/// Pure domain entity for an appointment.
class AppointmentEntity {
  final int id;
  final String appointmentType;
  final String status;
  final String appointmentDate;
  final String startTime;
  final String endTime;
  final int vehicleId;
  final String vehiclePlate;
  final String vehicleBrand;
  final String vehicleModel;
  final int clientId;
  final String clientFullName;
  final String clientEmail;
  final int? technicianId;
  final String? technicianFullName;
  final int currentMileage;
  final String? clientNotes;
  final String? adminNotes;
  final String createdAt;
  final String updatedAt;

  const AppointmentEntity({
    required this.id,
    required this.appointmentType,
    required this.status,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.vehicleId,
    required this.vehiclePlate,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.clientId,
    required this.clientFullName,
    required this.clientEmail,
    this.technicianId,
    this.technicianFullName,
    required this.currentMileage,
    this.clientNotes,
    this.adminNotes,
    required this.createdAt,
    required this.updatedAt,
  });
}

/// Domain entity for available slots.
class AvailableSlotsEntity {
  final String date;
  final String appointmentType;
  final List<AvailableSlotEntity> availableSlots;

  const AvailableSlotsEntity({
    required this.date,
    required this.appointmentType,
    required this.availableSlots,
  });
}

class AvailableSlotEntity {
  final String startTime;
  final String endTime;
  final int availableTechnicians;

  const AvailableSlotEntity({
    required this.startTime,
    required this.endTime,
    required this.availableTechnicians,
  });
}

/// Domain entity for plate restriction check result.
class PlateRestrictionEntity {
  final String vehiclePlate;
  final String restrictedDate;
  final String message;
  final String? urgentContactMessage;
  final String? phoneNumber;
  final String? businessHours;

  const PlateRestrictionEntity({
    required this.vehiclePlate,
    required this.restrictedDate,
    required this.message,
    this.urgentContactMessage,
    this.phoneNumber,
    this.businessHours,
  });

  /// True if the vehicle is restricted on this date.
  bool get isRestricted => urgentContactMessage != null;
}

/// Domain entity for rework contact info.
class ReworkInfoEntity {
  final String message;
  final String whatsappLink;
  final String phoneNumber;
  final String businessHours;

  const ReworkInfoEntity({
    required this.message,
    required this.whatsappLink,
    required this.phoneNumber,
    required this.businessHours,
  });
}
