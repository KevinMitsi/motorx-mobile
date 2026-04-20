/// Pure Dart entity for the authenticated user.
/// Domain layer — zero external dependencies.
class AuthEntity {
  final String token;
  final String type;
  final int userId;
  final String email;
  final String name;
  final String role;
  final String? employeePosition;
  final int? employeeId;

  const AuthEntity({
    required this.token,
    required this.type,
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
    this.employeePosition,
    this.employeeId,
  });
}
