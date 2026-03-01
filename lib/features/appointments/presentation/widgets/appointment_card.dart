import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/appointment_entity.dart';

/// Card widget displaying an appointment summary.
class AppointmentCard extends StatelessWidget {
  final AppointmentEntity appointment;
  final VoidCallback? onTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final statusColor = _statusColor(appointment.status, colorScheme);
    final statusLabel =
        AppStrings.appointmentStatusLabels[appointment.status] ??
            appointment.status;
    final typeLabel =
        AppStrings.appointmentTypeLabels[appointment.appointmentType] ??
            appointment.appointmentType;

    return Semantics(
      label: '$typeLabel, $statusLabel, ${appointment.appointmentDate}',
      button: true,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _typeIcon(appointment.appointmentType),
                        color: colorScheme.onPrimaryContainer,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            typeLabel,
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${appointment.vehicleBrand} ${appointment.vehicleModel} — ${appointment.vehiclePlate}',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    _StatusChip(label: statusLabel, color: statusColor),
                  ],
                ),
                const SizedBox(height: 12),
                // Date and time
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 14, color: colorScheme.primary),
                    const SizedBox(width: 6),
                    Text(
                      appointment.appointmentDate,
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time_rounded,
                        size: 14, color: colorScheme.primary),
                    const SizedBox(width: 6),
                    Text(
                      '${appointment.startTime} — ${appointment.endTime}',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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

  IconData _typeIcon(String type) => switch (type) {
        'OIL_CHANGE' => Icons.oil_barrel_rounded,
        'QUICK_SERVICE' => Icons.flash_on_rounded,
        'MAINTENANCE' => Icons.build_rounded,
        'MANUAL_WARRANTY_REVIEW' => Icons.menu_book_rounded,
        'AUTECO_WARRANTY' => Icons.verified_rounded,
        'UNPLANNED' => Icons.warning_amber_rounded,
        'REWORK' => Icons.replay_rounded,
        _ => Icons.calendar_month_rounded,
      };
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
