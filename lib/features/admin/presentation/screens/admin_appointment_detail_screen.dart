import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/admin_provider.dart';

/// Admin appointment detail screen — with cancel & change technician actions.
class AdminAppointmentDetailScreen extends ConsumerWidget {
  final int appointmentId;

  const AdminAppointmentDetailScreen({
    super.key,
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the detail on demand from datasource since admin agenda might 
    // not have been loaded.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Cita'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      body: FutureBuilder(
        future: ref
            .read(adminDatasourceProvider)
            .getAppointmentDetail(appointmentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final appt = snapshot.data!;
          final colorScheme = context.colorScheme;
          final textTheme = context.textTheme;
          final statusLabel =
              AppStrings.appointmentStatusLabels[appt.status] ??
                  appt.status;
          final typeLabel =
              AppStrings.appointmentTypeLabels[appt.appointmentType] ??
                  appt.appointmentType;
          final canCancel = appt.status == 'SCHEDULED' ||
              appt.status == 'IN_PROGRESS';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  typeLabel,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Chip(label: Text(statusLabel)),
                const SizedBox(height: 24),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _Row('Fecha', appt.appointmentDate),
                        _Row('Horario',
                            '${appt.startTime} — ${appt.endTime}'),
                        _Row('Vehículo',
                            '${appt.vehicleBrand} ${appt.vehicleModel}'),
                        _Row('Placa', appt.vehiclePlate),
                        _Row('Cliente', appt.clientFullName),
                        _Row('Email', appt.clientEmail),
                        _Row('Kilometraje',
                            '${appt.currentMileage} km'),
                        if (appt.technicianFullName != null)
                          _Row('Técnico', appt.technicianFullName!),
                        if (appt.clientNotes != null)
                          _Row('Notas cliente', appt.clientNotes!),
                        if (appt.adminNotes != null)
                          _Row('Notas admin', appt.adminNotes!),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Admin actions
                if (canCancel) ...[
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          _showCancelDialog(context, ref),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.error,
                        side: BorderSide(color: colorScheme.error),
                      ),
                      icon: const Icon(Icons.cancel_outlined),
                      label:
                          const Text(AppStrings.adminCancelAppointment),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        _showChangeTechnicianDialog(context, ref),
                    icon: const Icon(Icons.swap_horiz_rounded),
                    label: const Text(AppStrings.changeTechnician),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showCancelDialog(BuildContext context, WidgetRef ref) {
    final reasonController = TextEditingController();
    bool notifyClient = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Cancelar Cita'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Motivo de cancelación',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                title: const Text('Notificar al cliente'),
                value: notifyClient,
                onChanged: (v) =>
                    setDialogState(() => notifyClient = v ?? true),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () async {
                if (reasonController.text.trim().isEmpty) return;
                Navigator.pop(ctx);
                try {
                  final ds = ref.read(adminDatasourceProvider);
                  await ds.cancelAppointment(
                    appointmentId: appointmentId,
                    reason: reasonController.text.trim(),
                    notifyClient: notifyClient,
                  );
                  if (context.mounted) {
                    context.showSnackBar('Cita cancelada');
                    context.pop();
                  }
                } catch (e) {
                  if (context.mounted) {
                    context.showSnackBar(e.toString(), isError: true);
                  }
                }
              },
              child: Text(
                'Cancelar cita',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeTechnicianDialog(
      BuildContext context, WidgetRef ref) {
    final techController = TextEditingController();
    bool notifyClient = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text(AppStrings.changeTechnician),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: techController,
                decoration: const InputDecoration(
                  labelText: 'ID del nuevo técnico',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                title: const Text('Notificar al cliente'),
                value: notifyClient,
                onChanged: (v) =>
                    setDialogState(() => notifyClient = v ?? true),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () async {
                final techId =
                    int.tryParse(techController.text.trim());
                if (techId == null) return;
                Navigator.pop(ctx);
                try {
                  final ds = ref.read(adminDatasourceProvider);
                  await ds.changeTechnician(
                    appointmentId: appointmentId,
                    newTechnicianId: techId,
                    notifyClient: notifyClient,
                  );
                  if (context.mounted) {
                    context.showSnackBar('Técnico actualizado');
                    context.pop();
                  }
                } catch (e) {
                  if (context.mounted) {
                    context.showSnackBar(e.toString(), isError: true);
                  }
                }
              },
              child: const Text(AppStrings.confirm),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;

  const _Row(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
