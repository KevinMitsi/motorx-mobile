/// All API endpoint constants.
/// Never hardcode URLs inline — always reference this class.
class ApiEndpoints {
  ApiEndpoints._();

  // ── Base URL ──────────────────────────────────────────────
  static const String baseUrl = 'http://10.48.112.233:8080/api';

  // ── Auth ──────────────────────────────────────────────────
  static const String login = '/auth/login';
  static const String verify2fa = '/auth/verify-2fa';
  static const String register = '/auth/register';
  static const String me = '/auth/me';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // ── Password Reset ────────────────────────────────────────
  static const String passwordResetRequest = '/password-reset/request';
  static const String passwordReset = '/password-reset';

  // ── User: Appointments ────────────────────────────────────
  static const String userAvailableSlots =
      '/v1/user/appointments/available-slots';
  static const String userCheckPlateRestriction =
      '/v1/user/appointments/check-plate-restriction';
  static const String userReworkInfo = '/v1/user/appointments/rework-info';
  static const String userCreateAppointment = '/v1/user/appointments';
  static const String userMyAppointments = '/v1/user/appointments/my';
  static String userMyAppointmentDetail(int id) =>
      '/v1/user/appointments/my/$id';
  static String userVehicleAppointments(int vehicleId) =>
      '/v1/user/appointments/my/vehicle/$vehicleId';
  static String userCancelAppointment(int id) =>
      '/v1/user/appointments/my/$id';

  // ── User: Vehicles ────────────────────────────────────────
  static const String userVehicles = '/v1/user/vehicles';
  static String userVehicleDetail(int id) => '/v1/user/vehicles/$id';

  // ── Admin: Appointments ───────────────────────────────────
  static const String adminAgenda = '/v1/admin/appointments/agenda';
  static const String adminCalendar = '/v1/admin/appointments/calendar';
  static const String adminAvailableSlots =
      '/v1/admin/appointments/available-slots';
  static const String adminUnplannedAppointment =
      '/v1/admin/appointments/unplanned';
  static String adminCancelAppointment(int id) =>
      '/v1/admin/appointments/$id/cancel';
  static String adminChangeTechnician(int id) =>
      '/v1/admin/appointments/$id/technician';
  static String adminAppointmentDetail(int id) =>
      '/v1/admin/appointments/$id';
  static String adminClientAppointments(int clientId) =>
      '/v1/admin/appointments/client/$clientId';
  static String adminVehicleAppointments(int vehicleId) =>
      '/v1/admin/appointments/vehicle/$vehicleId';

  // ── Admin: Employees ──────────────────────────────────────
  static const String adminEmployees = '/v1/admin/employees';
  static String adminEmployeeDetail(int id) => '/v1/admin/employees/$id';

  // ── Admin: Users ──────────────────────────────────────────
  static const String adminUsers = '/v1/admin/users';
  static String adminUserDetail(int id) => '/v1/admin/users/$id';
  static String adminBlockUser(int id) => '/v1/admin/users/$id/block';
  static String adminUnblockUser(int id) => '/v1/admin/users/$id/unblock';
  static String adminDeleteUser(int id) => '/v1/admin/users/$id';

  // ── Admin: Vehicles ───────────────────────────────────────
  static const String adminVehicles = '/v1/admin/vehicles';
  static String adminVehicleDetail(int id) => '/v1/admin/vehicles/$id';
  static String adminTransferOwnership(int id) =>
      '/v1/admin/vehicles/$id/transfer-ownership';
}
