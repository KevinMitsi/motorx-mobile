import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_model.freezed.dart';
part 'vehicle_model.g.dart';

@freezed
class VehicleModel with _$VehicleModel {
  const factory VehicleModel({
    required int id,
    required String brand,
    required String model,
    required int yearOfManufacture,
    required String licensePlate,
    required int cylinderCapacity,
    required String chassisNumber,
    required int ownerId,
    required String ownerName,
    required String ownerEmail,
    required String createdAt,
    required String updatedAt,
  }) = _VehicleModel;

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);
}
