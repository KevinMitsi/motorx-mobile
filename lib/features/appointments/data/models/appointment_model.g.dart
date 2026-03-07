// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentModelImpl _$$AppointmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentModelImpl(
  id: (json['id'] as num).toInt(),
  appointmentType: json['appointmentType'] as String,
  status: json['status'] as String,
  appointmentDate: json['appointmentDate'] as String,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  vehicleId: (json['vehicleId'] as num).toInt(),
  vehiclePlate: json['vehiclePlate'] as String,
  vehicleBrand: json['vehicleBrand'] as String,
  vehicleModel: json['vehicleModel'] as String,
  clientId: (json['clientId'] as num).toInt(),
  clientFullName: json['clientFullName'] as String,
  clientEmail: json['clientEmail'] as String,
  technicianId: (json['technicianId'] as num?)?.toInt(),
  technicianFullName: json['technicianFullName'] as String?,
  currentMileage: (json['currentMileage'] as num).toInt(),
  clientNotes: json['clientNotes'] as String?,
  adminNotes: json['adminNotes'] as String?,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$$AppointmentModelImplToJson(
  _$AppointmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'appointmentType': instance.appointmentType,
  'status': instance.status,
  'appointmentDate': instance.appointmentDate,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'vehicleId': instance.vehicleId,
  'vehiclePlate': instance.vehiclePlate,
  'vehicleBrand': instance.vehicleBrand,
  'vehicleModel': instance.vehicleModel,
  'clientId': instance.clientId,
  'clientFullName': instance.clientFullName,
  'clientEmail': instance.clientEmail,
  'technicianId': instance.technicianId,
  'technicianFullName': instance.technicianFullName,
  'currentMileage': instance.currentMileage,
  'clientNotes': instance.clientNotes,
  'adminNotes': instance.adminNotes,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

_$AvailableSlotsModelImpl _$$AvailableSlotsModelImplFromJson(
  Map<String, dynamic> json,
) => _$AvailableSlotsModelImpl(
  date: json['date'] as String,
  appointmentType: json['appointmentType'] as String,
  availableSlots: (json['availableSlots'] as List<dynamic>)
      .map((e) => AvailableSlotModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$AvailableSlotsModelImplToJson(
  _$AvailableSlotsModelImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'appointmentType': instance.appointmentType,
  'availableSlots': instance.availableSlots,
};

_$AvailableSlotModelImpl _$$AvailableSlotModelImplFromJson(
  Map<String, dynamic> json,
) => _$AvailableSlotModelImpl(
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  availableTechnicians: (json['availableTechnicians'] as num).toInt(),
);

Map<String, dynamic> _$$AvailableSlotModelImplToJson(
  _$AvailableSlotModelImpl instance,
) => <String, dynamic>{
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'availableTechnicians': instance.availableTechnicians,
};

_$PlateRestrictionModelImpl _$$PlateRestrictionModelImplFromJson(
  Map<String, dynamic> json,
) => _$PlateRestrictionModelImpl(
  vehiclePlate: json['vehiclePlate'] as String,
  restrictedDate: json['restrictedDate'] as String,
  message: json['message'] as String,
  urgentContactMessage: json['urgentContactMessage'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  businessHours: json['businessHours'] as String?,
);

Map<String, dynamic> _$$PlateRestrictionModelImplToJson(
  _$PlateRestrictionModelImpl instance,
) => <String, dynamic>{
  'vehiclePlate': instance.vehiclePlate,
  'restrictedDate': instance.restrictedDate,
  'message': instance.message,
  'urgentContactMessage': instance.urgentContactMessage,
  'phoneNumber': instance.phoneNumber,
  'businessHours': instance.businessHours,
};

_$ReworkInfoModelImpl _$$ReworkInfoModelImplFromJson(
  Map<String, dynamic> json,
) => _$ReworkInfoModelImpl(
  message: json['message'] as String,
  whatsappLink: json['whatsappLink'] as String,
  phoneNumber: json['phoneNumber'] as String,
  businessHours: json['businessHours'] as String,
);

Map<String, dynamic> _$$ReworkInfoModelImplToJson(
  _$ReworkInfoModelImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'whatsappLink': instance.whatsappLink,
  'phoneNumber': instance.phoneNumber,
  'businessHours': instance.businessHours,
};
