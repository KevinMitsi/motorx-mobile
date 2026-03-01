import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

/// Admin dashboard home screen with links to all admin features.
class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final userName = authState.valueOrNull?.name ?? 'Admin';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: colorScheme.secondaryContainer,
                    child: Icon(
                      Icons.admin_panel_settings_rounded,
                      color: colorScheme.onSecondaryContainer,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.adminPanel,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          userName,
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push(AppRoutes.profile),
                    icon: const Icon(Icons.settings_rounded),
                    tooltip: 'Perfil',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Appointments section
              _SectionTitle(
                title: 'Citas',
                icon: Icons.calendar_month_rounded,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 12),
              _AdminActionCard(
                icon: Icons.today_rounded,
                title: AppStrings.agenda,
                subtitle: 'Ver todas las citas de hoy',
                onTap: () => context.push(AppRoutes.adminAgenda),
              ),
              _AdminActionCard(
                icon: Icons.date_range_rounded,
                title: AppStrings.calendar,
                subtitle: 'Vista calendario de citas',
                onTap: () => context.push(AppRoutes.adminCalendar),
              ),
              _AdminActionCard(
                icon: Icons.add_circle_outline_rounded,
                title: AppStrings.unplannedAppointment,
                subtitle: 'Registrar cita sin previa',
                onTap: () => context.push(AppRoutes.adminUnplanned),
              ),
              const SizedBox(height: 24),

              // Management section
              _SectionTitle(
                title: 'Gestión',
                icon: Icons.business_center_rounded,
                color: colorScheme.secondary,
              ),
              const SizedBox(height: 12),
              _AdminActionCard(
                icon: Icons.engineering_rounded,
                title: AppStrings.employees,
                subtitle: 'Administrar empleados del taller',
                onTap: () => context.push(AppRoutes.adminEmployees),
              ),
              _AdminActionCard(
                icon: Icons.people_rounded,
                title: AppStrings.users,
                subtitle: 'Gestionar usuarios de la app',
                onTap: () => context.push(AppRoutes.adminUsers),
              ),
              _AdminActionCard(
                icon: Icons.motorcycle_rounded,
                title: AppStrings.allVehicles,
                subtitle: 'Ver y transferir vehículos',
                onTap: () => context.push(AppRoutes.adminVehicles),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _SectionTitle({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
        ),
      ],
    );
  }
}

class _AdminActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AdminActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: title,
      button: true,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: colorScheme.primaryContainer,
            child: Icon(icon, color: colorScheme.onPrimaryContainer),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: Text(subtitle),
          trailing: Icon(
            Icons.chevron_right_rounded,
            color: colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
