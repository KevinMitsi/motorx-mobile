/// Pure domain entity for Employee.
class EmployeeEntity {
  final int employeeId;
  final String position;
  final String state;
  final String hireDate;
  final int userId;
  final String userName;
  final String userEmail;
  final String userDni;
  final String userPhone;
  final String createdAt;
  final String updatedAt;

  const EmployeeEntity({
    required this.employeeId,
    required this.position,
    required this.state,
    required this.hireDate,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userDni,
    required this.userPhone,
    required this.createdAt,
    required this.updatedAt,
  });
}

/// Pure domain entity for admin-view user.
class AdminUserEntity {
  final int id;
  final String name;
  final String dni;
  final String email;
  final String phone;
  final String role;
  final bool enabled;
  final bool accountLocked;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  const AdminUserEntity({
    required this.id,
    required this.name,
    required this.dni,
    required this.email,
    required this.phone,
    required this.role,
    required this.enabled,
    required this.accountLocked,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  bool get isDeleted => deletedAt != null;
}
