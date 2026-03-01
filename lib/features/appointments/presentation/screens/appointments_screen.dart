import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/appointment_entity.dart';
import '../providers/appointment_provider.dart';
import '../widgets/appointment_card.dart';

/// Screen showing the user's appointment list.
class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsState = ref.watch(appointmentListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myAppointments),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.createAppointment),
        icon: const Icon(Icons.add_rounded),
        label: const Text(AppStrings.newAppointment),
        tooltip: AppStrings.newAppointment,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(appointmentListNotifierProvider.notifier).refresh(),
        child: appointmentsState.when(
          data: (appointments) {
            if (appointments.isEmpty) {
              return EmptyStateWidget(
                title: AppStrings.noAppointments,
                subtitle: AppStrings.noAppointmentsHint,
                icon: Icons.calendar_month_rounded,
                actionLabel: AppStrings.newAppointment,
                onAction: () => context.push(AppRoutes.createAppointment),
              );
            }

            // Sort: upcoming first (SCHEDULED), then rest by date desc
            final sorted = List<AppointmentEntity>.from(appointments)
              ..sort((a, b) {
                const priority = {
                  'SCHEDULED': 0,
                  'IN_PROGRESS': 1,
                };
                final pa = priority[a.status] ?? 2;
                final pb = priority[b.status] ?? 2;
                if (pa != pb) return pa.compareTo(pb);
                return b.appointmentDate.compareTo(a.appointmentDate);
              });

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                final appointment = sorted[index];
                return AppointmentCard(
                  appointment: appointment,
                  onTap: () => context
                      .push('/appointments/${appointment.id}'),
                );
              },
            );
          },
          loading: () => const LoadingWidget(message: 'Cargando citas...'),
          error: (e, _) => AppErrorWidget(
            message: e.toString(),
            onRetry: () =>
                ref.read(appointmentListNotifierProvider.notifier).refresh(),
          ),
        ),
      ),
    );
  }
}
