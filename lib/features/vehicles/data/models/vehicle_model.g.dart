// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleModelImpl _$$VehicleModelImplFromJson(Map<String, dynamic> json) =>
    _$VehicleModelImpl(
      id: (json['id'] as num).toInt(),
      brand: json['brand'] as String,
      model: json['model'] as String,
      yearOfManufacture: (json['yearOfManufacture'] as num).toInt(),
      licensePlate: json['licensePlate'] as String,
      cylinderCapacity: (json['cylinderCapacity'] as num).toInt(),
      chassisNumber: json['chassisNumber'] as String,
      ownerId: (json['ownerId'] as num).toInt(),
      ownerName: json['ownerName'] as String,
      ownerEmail: json['ownerEmail'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$VehicleModelImplToJson(_$VehicleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'model': instance.model,
      'yearOfManufacture': instance.yearOfManufacture,
      'licensePlate': instance.licensePlate,
      'cylinderCapacity': instance.cylinderCapacity,
      'chassisNumber': instance.chassisNumber,
      'ownerId': instance.ownerId,
      'ownerName': instance.ownerName,
      'ownerEmail': instance.ownerEmail,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
