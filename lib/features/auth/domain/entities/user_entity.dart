/// Pure Dart entity for the user profile.
/// Domain layer — zero external dependencies.
class UserEntity {
  final int id;
  final String name;
  final String dni;
  final String email;
  final String phone;
  final String createdAt;
  final String role;
  final String? employeePosition;
  final int? employeeId;
  final bool enabled;
  final bool accountLocked;
  final String updatedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.dni,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.role,
    this.employeePosition,
    this.employeeId,
    required this.enabled,
    required this.accountLocked,
    required this.updatedAt,
  });
}
