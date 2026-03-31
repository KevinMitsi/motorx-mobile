/// Centralized string constants for the MotorX app.
/// Avoids magic strings across the codebase.
class AppStrings {
  AppStrings._();

  // ── App ───────────────────────────────────────────────────
  static const String appName = 'MotorX';
  static const String appTagline = 'Tu taller de confianza';

  // ── Auth ──────────────────────────────────────────────────
  static const String login = 'Iniciar Sesión';
  static const String register = 'Registrarse';
  static const String logout = 'Cerrar Sesión';
  static const String email = 'Correo electrónico';
  static const String password = 'Contraseña';
  static const String confirmPassword = 'Confirmar contraseña';
  static const String name = 'Nombre completo';
  static const String dni = 'Documento de identidad';
  static const String phone = 'Teléfono';
  static const String forgotPassword = '¿Olvidaste tu contraseña?';
  static const String noAccount = '¿No tienes cuenta?';
  static const String hasAccount = '¿Ya tienes cuenta?';
  static const String verify2fa = 'Verificar código';
  static const String code2fa = 'Código de verificación';
  static const String code2faHint = 'Ingresa el código de 6 dígitos';
  static const String codeSentTo = 'Se envió un código de verificación a';
  static const String resetPassword = 'Restablecer contraseña';
  static const String newPassword = 'Nueva contraseña';
  static const String sendResetCode = 'Enviar código';
  static const String resetToken = 'Código de recuperación';

  // ── Vehicles ──────────────────────────────────────────────
  static const String myVehicles = 'Mis Vehículos';
  static const String addVehicle = 'Agregar Vehículo';
  static const String editVehicle = 'Editar Vehículo';
  static const String brand = 'Marca';
  static const String model = 'Modelo';
  static const String year = 'Año de fabricación';
  static const String licensePlate = 'Placa';
  static const String cylinderCapacity = 'Cilindraje (cc)';
  static const String chassisNumber = 'Número de chasis';
  static const String deleteVehicle = 'Eliminar vehículo';
  static const String deleteVehicleConfirm =
      '¿Estás seguro de que deseas eliminar este vehículo?';
  static const String noVehicles = 'No tienes vehículos registrados';
  static const String noVehiclesHint =
      'Agrega tu primera moto para comenzar a agendar citas';

  // ── Appointments ──────────────────────────────────────────
  static const String myAppointments = 'Mis Citas';
  static const String newAppointment = 'Agendar Cita';
  static const String appointmentDetail = 'Detalle de Cita';
  static const String cancelAppointment = 'Cancelar Cita';
  static const String cancelAppointmentConfirm =
      '¿Estás seguro de que deseas cancelar esta cita?';
  static const String selectVehicle = 'Seleccionar vehículo';
  static const String selectType = 'Tipo de servicio';
  static const String selectDate = 'Fecha';
  static const String selectTime = 'Horario disponible';
  static const String currentMileage = 'Kilometraje actual';
  static const String clientNotes = 'Notas adicionales';
  static const String noAppointments = 'No tienes citas registradas';
  static const String noAppointmentsHint =
      'Agenda tu primera cita para darle mantenimiento a tu moto';

  // ── Appointment Types ─────────────────────────────────────
  static const Map<String, String> appointmentTypeLabels = {
    'MANUAL_WARRANTY_REVIEW': 'Revisión de garantía de manual',
    'AUTECO_WARRANTY': 'Garantía Auteco',
    'QUICK_SERVICE': 'Servicio rápido',
    'MAINTENANCE': 'Mantenimiento general',
    'OIL_CHANGE': 'Cambio de aceite',
    'UNPLANNED': 'Cita no planeada',
    'REWORK': 'Reproceso',
  };

  // ── Appointment Status ────────────────────────────────────
  static const Map<String, String> appointmentStatusLabels = {
    'SCHEDULED': 'Agendada',
    'IN_PROGRESS': 'En progreso',
    'COMPLETED': 'Completada',
    'CANCELLED': 'Cancelada',
    'REJECTED': 'Rechazada',
    'NO_SHOW': 'No asistió',
  };

  // ── Admin ─────────────────────────────────────────────────
  static const String adminPanel = 'Panel de Administración';
  static const String agenda = 'Agenda del día';
  static const String calendar = 'Calendario';
  static const String employees = 'Empleados';
  static const String users = 'Usuarios';
  static const String allVehicles = 'Vehículos';
  static const String createEmployee = 'Crear Empleado';
  static const String editEmployee = 'Editar Empleado';
  static const String blockUser = 'Bloquear usuario';
  static const String unblockUser = 'Desbloquear usuario';
  static const String deleteUser = 'Eliminar usuario';
  static const String transferOwnership = 'Transferir propiedad';
  static const String unplannedAppointment = 'Cita no planeada';
  static const String changeTechnician = 'Cambiar técnico';
  static const String adminCancelAppointment = 'Cancelar cita';
  static const String adminMetrics = 'Métricas';
  static const String adminLogs = 'Logs de auditoría';

  // ── Employee Positions ────────────────────────────────────
  static const Map<String, String> employeePositionLabels = {
    'RECEPCIONISTA': 'Recepcionista',
    'MECANICO': 'Mecánico',
  };

  // ── Employee States ───────────────────────────────────────
  static const Map<String, String> employeeStateLabels = {
    'AVAILABLE': 'Disponible',
    'NOT_AVAILABLE': 'No disponible',
  };

  // ── Roles ─────────────────────────────────────────────────
  static const Map<String, String> roleLabels = {
    'CLIENT': 'Cliente',
    'EMPLOYEE': 'Empleado',
    'ADMIN': 'Administrador',
  };

  // ── Generic ───────────────────────────────────────────────
  static const String save = 'Guardar';
  static const String cancel = 'Cancelar';
  static const String delete = 'Eliminar';
  static const String edit = 'Editar';
  static const String confirm = 'Confirmar';
  static const String loading = 'Cargando...';
  static const String retry = 'Reintentar';
  static const String error = 'Error';
  static const String success = 'Éxito';
  static const String noData = 'Sin datos';
  static const String search = 'Buscar';
  static const String close = 'Cerrar';
  static const String ok = 'Aceptar';
  static const String yes = 'Sí';
  static const String no = 'No';

  // ── Validation ────────────────────────────────────────────
  static const String fieldRequired = 'Este campo es requerido';
  static const String invalidEmail = 'Ingresa un correo electrónico válido';
  static const String passwordTooShort = 'Mínimo 6 caracteres';
  static const String invalidPhone = 'Ingresa un teléfono válido';
  static const String invalidPlate = 'Formato de placa inválido (ej: ABC12D)';
  static const String invalidDni = 'Documento de identidad inválido';

  // ── Network ───────────────────────────────────────────────
  static const String networkError =
      'Error de conexión. Verifica tu conexión a internet.';
  static const String serverError =
      'Error del servidor. Intenta de nuevo más tarde.';
  static const String unauthorizedError =
      'Sesión expirada. Inicia sesión nuevamente.';
  static const String unknownError = 'Ocurrió un error inesperado.';
}
