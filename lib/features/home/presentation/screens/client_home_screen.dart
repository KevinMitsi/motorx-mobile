import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

/// Main home screen for CLIENT / EMPLOYEE roles.
class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final userName = authState.valueOrNull?.name ?? 'Usuario';
    final role = authState.valueOrNull?.role ?? 'CLIENT';
    final employeePosition = authState.valueOrNull?.employeePosition;
    final isEmployee = role == 'EMPLOYEE';
    final isWarehouse = employeePosition == 'WAREHOUSE_WORKER';
    final isReceptionist = employeePosition == 'RECEPCIONISTA';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(
                      Icons.person_rounded,
                      color: colorScheme.onPrimaryContainer,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Hola!',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
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
              const SizedBox(height: 32),

              // Brand banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.appName,
                      style: textTheme.headlineMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.appTagline,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () =>
                          context.push(AppRoutes.createAppointment),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text(AppStrings.newAppointment),
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.onPrimary,
                        foregroundColor: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick actions title
              Text(
                'Accesos rápidos',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              // Quick action cards
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.motorcycle_rounded,
                      label: AppStrings.myVehicles,
                      color: colorScheme.primary,
                      containerColor: colorScheme.primaryContainer,
                      onTap: () => context.push(AppRoutes.vehicles),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.calendar_month_rounded,
                      label: AppStrings.myAppointments,
                      color: colorScheme.secondary,
                      containerColor: colorScheme.secondaryContainer,
                      onTap: () => context.push(AppRoutes.appointments),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.add_circle_outline_rounded,
                      label: AppStrings.newAppointment,
                      color: colorScheme.tertiary,
                      containerColor: colorScheme.tertiaryContainer,
                      onTap: () => context.push(AppRoutes.createAppointment),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.notifications_rounded,
                      label: AppStrings.notifications,
                      color: colorScheme.primary,
                      containerColor: colorScheme.primaryContainer,
                      onTap: () => context.push(AppRoutes.notifications),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.person_rounded,
                      label: 'Mi Perfil',
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                      containerColor: colorScheme.surfaceContainerHighest,
                      onTap: () => context.push(AppRoutes.profile),
                    ),
                  ),
                  if (role == 'CLIENT') ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickActionCard(
                        icon: Icons.smart_toy_rounded,
                        label: AppStrings.chatbot,
                        color: colorScheme.secondary,
                        containerColor: colorScheme.secondaryContainer,
                        onTap: () => context.push(AppRoutes.chatbot),
                      ),
                    ),
                  ],
                ],
              ),
              if (isEmployee) ...[
                const SizedBox(height: 24),
                Text(
                  'Operación',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                if (isWarehouse || (!isWarehouse && !isReceptionist))
                  _OperationTile(
                    icon: Icons.build_rounded,
                    title: AppStrings.spares,
                    subtitle: 'Consulta y gestión de repuestos',
                    onTap: () => context.push(AppRoutes.spares),
                  ),
                if (isWarehouse || (!isWarehouse && !isReceptionist))
                  _OperationTile(
                    icon: Icons.swap_horiz_rounded,
                    title: AppStrings.inventory,
                    subtitle: 'Registro de compras y ventas',
                    onTap: () => context.push(AppRoutes.inventory),
                  ),
                if (isReceptionist || (!isWarehouse && !isReceptionist))
                  _OperationTile(
                    icon: Icons.fact_check_rounded,
                    title: AppStrings.reception,
                    subtitle: 'Flujo de recepción con código',
                    onTap: () => context.push(AppRoutes.reception),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OperationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _OperationTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.secondaryContainer,
          child: Icon(icon, color: colorScheme.onSecondaryContainer),
        ),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color containerColor;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.containerColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: Card(
        elevation: 0,
        color: containerColor.withValues(alpha: 0.3),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(icon, size: 32, color: color),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
