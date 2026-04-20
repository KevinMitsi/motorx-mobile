import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/verify_2fa_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/home/presentation/screens/client_home_screen.dart';
import '../features/home/presentation/screens/admin_home_screen.dart';
import '../features/vehicles/presentation/screens/vehicles_screen.dart';
import '../features/vehicles/presentation/screens/add_vehicle_screen.dart';
import '../features/vehicles/presentation/screens/edit_vehicle_screen.dart';
import '../features/vehicles/presentation/screens/vehicle_detail_screen.dart';
import '../features/appointments/presentation/screens/appointments_screen.dart';
import '../features/appointments/presentation/screens/create_appointment_screen.dart';
import '../features/appointments/presentation/screens/appointment_detail_screen.dart';
import '../features/admin/presentation/screens/agenda_screen.dart';
import '../features/admin/presentation/screens/calendar_screen.dart';
import '../features/admin/presentation/screens/unplanned_appointment_screen.dart';
import '../features/admin/presentation/screens/employees_screen.dart';
import '../features/admin/presentation/screens/create_employee_screen.dart';
import '../features/admin/presentation/screens/edit_employee_screen.dart';
import '../features/admin/presentation/screens/admin_users_screen.dart';
import '../features/admin/presentation/screens/admin_vehicles_screen.dart';
import '../features/admin/presentation/screens/admin_appointment_detail_screen.dart';
import '../features/admin/presentation/screens/admin_metrics_screen.dart';
import '../features/admin/presentation/screens/admin_logs_screen.dart';
import '../features/admin/presentation/screens/admin_inventory_metrics_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/spares/presentation/screens/spares_screen.dart';
import '../features/inventory/presentation/screens/inventory_screen.dart';
import '../features/reception/presentation/screens/reception_screen.dart';
import '../features/notifications/presentation/screens/notifications_screen.dart';
import '../features/chatbot/presentation/screens/chatbot_screen.dart';

/// Route path constants to avoid magic strings.
class AppRoutes {
  AppRoutes._();

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String verify2fa = '/verify-2fa';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  // Client
  static const String clientHome = '/';
  static const String vehicles = '/vehicles';
  static const String addVehicle = '/vehicles/add';
  static const String editVehicle = '/vehicles/edit/:id';
  static const String vehicleDetail = '/vehicles/:id';
  static const String appointments = '/appointments';
  static const String createAppointment = '/appointments/create';
  static const String appointmentDetail = '/appointments/:id';
  static const String profile = '/profile';

  // Admin
  static const String adminHome = '/admin';
  static const String adminAgenda = '/admin/agenda';
  static const String adminCalendar = '/admin/calendar';
  static const String adminUnplanned = '/admin/unplanned';
  static const String adminEmployees = '/admin/employees';
  static const String adminCreateEmployee = '/admin/employees/create';
  static const String adminEditEmployee = '/admin/employees/edit/:id';
  static const String adminUsers = '/admin/users';
  static const String adminVehicles = '/admin/vehicles';
  static const String adminAppointmentDetail = '/admin/appointments/:id';
  static const String adminMetrics = '/admin/metrics';
  static const String adminInventoryMetrics = '/admin/metrics/inventory';
  static const String adminLogs = '/admin/logs';

  // Inventory & Reception
  static const String spares = '/spares';
  static const String sparesBelowThreshold = '/spares/below-threshold';
  static const String inventory = '/inventory';
  static const String reception = '/reception';
  static const String notifications = '/notifications';
  static const String chatbot = '/chatbot';
}

/// ChangeNotifier that listens to auth state changes and notifies go_router
/// to re-run redirect — without ever recreating the GoRouter.
class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(Ref ref) {
    ref.listen<AsyncValue>(authNotifierProvider, (_, __) {
      notifyListeners();
    });
  }
}

/// go_router configuration with auth redirect.
/// The GoRouter is created ONCE; _RouterNotifier triggers refresh on auth
/// changes so redirect is re-evaluated without disposing the widget tree.
final routerProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);

  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register ||
          state.matchedLocation == AppRoutes.verify2fa ||
          state.matchedLocation == AppRoutes.forgotPassword ||
          state.matchedLocation == AppRoutes.resetPassword;

      if (!isLoggedIn && !isAuthRoute) {
        return AppRoutes.login;
      }

      if (isLoggedIn && isAuthRoute) {
        final user = authState.valueOrNull;
        if (user?.role == 'ADMIN') {
          return AppRoutes.adminHome;
        }
        if (user?.role == 'EMPLOYEE' &&
            user?.employeePosition == 'WAREHOUSE_WORKER') {
          return AppRoutes.spares;
        }
        if (user?.role == 'EMPLOYEE' &&
            user?.employeePosition == 'RECEPCIONISTA') {
          return AppRoutes.reception;
        }
        return AppRoutes.clientHome;
      }

      if (isLoggedIn && state.matchedLocation == AppRoutes.chatbot) {
        final user = authState.valueOrNull;
        if (user?.role != 'CLIENT') {
          if (user?.role == 'ADMIN') {
            return AppRoutes.adminHome;
          }
          if (user?.role == 'EMPLOYEE' &&
              user?.employeePosition == 'WAREHOUSE_WORKER') {
            return AppRoutes.spares;
          }
          if (user?.role == 'EMPLOYEE' &&
              user?.employeePosition == 'RECEPCIONISTA') {
            return AppRoutes.reception;
          }
          return AppRoutes.clientHome;
        }
      }

      if (isLoggedIn &&
          state.matchedLocation.startsWith('/admin') &&
          authState.valueOrNull?.role != 'ADMIN') {
        return AppRoutes.clientHome;
      }

      return null;
    },
    routes: [
      // ── Auth Routes ─────────────────────────────────────
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.verify2fa,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return Verify2FAScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),

      // ── Client Routes ───────────────────────────────────
      GoRoute(
        path: AppRoutes.clientHome,
        builder: (context, state) => const ClientHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.vehicles,
        builder: (context, state) => const VehiclesScreen(),
      ),
      GoRoute(
        path: AppRoutes.addVehicle,
        builder: (context, state) => const AddVehicleScreen(),
      ),
      GoRoute(
        path: AppRoutes.editVehicle,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return EditVehicleScreen(vehicleId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.vehicleDetail,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return VehicleDetailScreen(vehicleId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.appointments,
        builder: (context, state) => const AppointmentsScreen(),
      ),
      GoRoute(
        path: AppRoutes.createAppointment,
        builder: (context, state) => const CreateAppointmentScreen(),
      ),
      GoRoute(
        path: AppRoutes.appointmentDetail,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return AppointmentDetailScreen(appointmentId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),

      // ── Admin Routes ────────────────────────────────────
      GoRoute(
        path: AppRoutes.adminHome,
        builder: (context, state) => const AdminHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminAgenda,
        builder: (context, state) => const AgendaScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminCalendar,
        builder: (context, state) => const CalendarScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminUnplanned,
        builder: (context, state) => const UnplannedAppointmentScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminEmployees,
        builder: (context, state) => const EmployeesScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminCreateEmployee,
        builder: (context, state) => const CreateEmployeeScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminEditEmployee,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return EditEmployeeScreen(employeeId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.adminUsers,
        builder: (context, state) => const AdminUsersScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminVehicles,
        builder: (context, state) => const AdminVehiclesScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminAppointmentDetail,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return AdminAppointmentDetailScreen(appointmentId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.adminMetrics,
        builder: (context, state) => const AdminMetricsScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminInventoryMetrics,
        builder: (context, state) => const AdminInventoryMetricsScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminLogs,
        builder: (context, state) => const AdminLogsScreen(),
      ),

      // ── Inventory / Reception / Notifications / Chatbot ──
      GoRoute(
        path: AppRoutes.spares,
        builder: (context, state) => const SparesScreen(),
      ),
      GoRoute(
        path: AppRoutes.sparesBelowThreshold,
        builder: (context, state) =>
            const SparesScreen(belowThresholdOnly: true),
      ),
      GoRoute(
        path: AppRoutes.inventory,
        builder: (context, state) => const InventoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.reception,
        builder: (context, state) => const ReceptionScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.chatbot,
        builder: (context, state) => const ChatbotScreen(),
      ),
    ],
  );
});
