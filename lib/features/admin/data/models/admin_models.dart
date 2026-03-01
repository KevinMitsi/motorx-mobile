import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_models.freezed.dart';
part 'admin_models.g.dart';

/// Model matching `EmployeeResponseDTO` from the API.
@freezed
class EmployeeModel with _$EmployeeModel {
  const factory EmployeeModel({
    required int employeeId,
    required String position,
    required String state,
    required String hireDate,
    required int userId,
    required String userName,
    required String userEmail,
    required String userDni,
    required String userPhone,
    required String createdAt,
    required String updatedAt,
  }) = _EmployeeModel;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);
}

/// Model matching `AdminUserResponseDTO` from the API.
@freezed
class AdminUserModel with _$AdminUserModel {
  const factory AdminUserModel({
    required int id,
    required String name,
    required String dni,
    required String email,
    required String phone,
    required String role,
    required bool enabled,
    required bool accountLocked,
    required String createdAt,
    required String updatedAt,
    String? deletedAt,
  }) = _AdminUserModel;

  factory AdminUserModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUserModelFromJson(json);
}
