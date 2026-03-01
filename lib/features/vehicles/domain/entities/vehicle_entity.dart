/// Pure Dart entity representing a vehicle (motorcycle).
class VehicleEntity {
  final int id;
  final String brand;
  final String model;
  final int yearOfManufacture;
  final String licensePlate;
  final int cylinderCapacity;
  final String chassisNumber;
  final int ownerId;
  final String ownerName;
  final String ownerEmail;
  final String createdAt;
  final String updatedAt;

  const VehicleEntity({
    required this.id,
    required this.brand,
    required this.model,
    required this.yearOfManufacture,
    required this.licensePlate,
    required this.cylinderCapacity,
    required this.chassisNumber,
    required this.ownerId,
    required this.ownerName,
    required this.ownerEmail,
    required this.createdAt,
    required this.updatedAt,
  });
}
