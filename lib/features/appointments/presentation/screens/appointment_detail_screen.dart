import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/appointment_provider.dart';

/// Detail screen for a specific appointment.
class AppointmentDetailScreen extends ConsumerWidget {
  final int appointmentId;

  const AppointmentDetailScreen({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsState = ref.watch(appointmentListNotifierProvider);
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appointmentDetail),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      body: appointmentsState.when(
        data: (appointments) {
          final appt = appointments
              .where((a) => a.id == appointmentId)
              .firstOrNull;
          if (appt == null) {
            return const Center(child: Text('Cita no encontrada'));
          }

          final statusLabel =
              AppStrings.appointmentStatusLabels[appt.status] ??
                  appt.status;
          final typeLabel =
              AppStrings.appointmentTypeLabels[appt.appointmentType] ??
                  appt.appointmentType;
          final statusColor = _statusColor(appt.status, colorScheme);
          final canCancel = appt.status == 'SCHEDULED';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Status badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_statusIcon(appt.status),
                          size: 18, color: statusColor),
                      const SizedBox(width: 8),
                      Text(
                        statusLabel,
                        style: textTheme.titleSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  typeLabel,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Details card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _DetailRow(
                          icon: Icons.calendar_today_outlined,
                          label: 'Fecha',
                          value: appt.appointmentDate,
                        ),
                        const Divider(height: 20),
                        _DetailRow(
                          icon: Icons.access_time_rounded,
                          label: 'Horario',
                          value: '${appt.startTime} — ${appt.endTime}',
                        ),
                        const Divider(height: 20),
                        _DetailRow(
                          icon: Icons.motorcycle_rounded,
                          label: 'Vehículo',
                          value:
                              '${appt.vehicleBrand} ${appt.vehicleModel}',
                        ),
                        const Divider(height: 20),
                        _DetailRow(
                          icon: Icons.pin_outlined,
                          label: 'Placa',
                          value: appt.vehiclePlate,
                        ),
                        const Divider(height: 20),
                        _DetailRow(
                          icon: Icons.speed_rounded,
                          label: 'Kilometraje',
                          value: '${appt.currentMileage} km',
                        ),
                        if (appt.technicianFullName != null) ...[
                          const Divider(height: 20),
                          _DetailRow(
                            icon: Icons.engineering_rounded,
                            label: 'Técnico',
                            value: appt.technicianFullName!,
                          ),
                        ],
                        if (appt.clientNotes != null &&
                            appt.clientNotes!.isNotEmpty) ...[
                          const Divider(height: 20),
                          _DetailRow(
                            icon: Icons.notes_rounded,
                            label: 'Notas',
                            value: appt.clientNotes!,
                          ),
                        ],
                        if (appt.adminNotes != null &&
                            appt.adminNotes!.isNotEmpty) ...[
                          const Divider(height: 20),
                          _DetailRow(
                            icon: Icons.admin_panel_settings_rounded,
                            label: 'Notas admin',
                            value: appt.adminNotes!,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Cancel button
                if (canCancel)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          _confirmCancel(context, ref, appointmentId),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.error,
                        side: BorderSide(color: colorScheme.error),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text(AppStrings.cancelAppointment),
                    ),
                  ),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  Color _statusColor(String status, ColorScheme cs) => switch (status) {
        'SCHEDULED' => cs.primary,
        'IN_PROGRESS' => Colors.orange,
        'COMPLETED' => Colors.green,
        'CANCELLED' => cs.error,
        'REJECTED' => cs.error,
        'NO_SHOW' => Colors.grey,
        _ => cs.onSurface,
      };

  IconData _statusIcon(String status) => switch (status) {
        'SCHEDULED' => Icons.schedule_rounded,
        'IN_PROGRESS' => Icons.play_circle_rounded,
        'COMPLETED' => Icons.check_circle_rounded,
        'CANCELLED' => Icons.cancel_rounded,
        'REJECTED' => Icons.block_rounded,
        'NO_SHOW' => Icons.person_off_rounded,
        _ => Icons.info_rounded,
      };

  void _confirmCancel(BuildContext context, WidgetRef ref, int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.cancelAppointment),
        content: const Text(AppStrings.cancelAppointmentConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await ref
                    .read(appointmentListNotifierProvider.notifier)
                    .cancelAppointment(id);
                if (context.mounted) {
                  context.showSnackBar('Cita cancelada exitosamente');
                }
              } catch (e) {
                if (context.mounted) {
                  context.showSnackBar(e.toString(), isError: true);
                }
              }
            },
            child: Text(
              'Sí, cancelar',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: '$label: $value',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
