import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    required String token,
    required String type,
    required int userId,
    required String email,
    required String name,
    required String role,
    String? employeePosition,
    int? employeeId,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}
