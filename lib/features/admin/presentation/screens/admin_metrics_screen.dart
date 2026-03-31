import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/admin_entities.dart';
import '../providers/admin_provider.dart';

/// Admin screen for operational and quality metrics.
class AdminMetricsScreen extends ConsumerWidget {
  const AdminMetricsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsState = ref.watch(adminMetricsNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.adminMetrics),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(adminMetricsNotifierProvider.notifier).refresh(),
        child: metricsState.when(
          data: (summary) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionHeader(
                icon: Icons.speed_rounded,
                title: 'Performance',
                color: colorScheme.primary,
              ),
              const SizedBox(height: 8),
              ...summary.performance.map(
                (metric) => _PerformanceCard(metric: metric),
              ),
              const SizedBox(height: 16),
              _SectionHeader(
                icon: Icons.security_rounded,
                title: 'Seguridad',
                color: colorScheme.secondary,
              ),
              const SizedBox(height: 8),
              _StatGroupCard(
                title: 'Control de acceso',
                stats: [
                  _StatItem(
                    'Intentos 401',
                    '${summary.security.unauthorizedAttempts401}',
                  ),
                  _StatItem(
                    'Intentos 403',
                    '${summary.security.forbiddenAttempts403}',
                  ),
                  _StatItem(
                    'Cumplimiento',
                    '${summary.security.accessControlCompliancePercent.toStringAsFixed(2)}%',
                  ),
                  _StatItem(
                    'Endpoints protegidos',
                    '${summary.security.endpointsWithAuthEnforced}/${summary.security.totalProtectedEndpoints}',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _SectionHeader(
                icon: Icons.construction_rounded,
                title: 'Mantenibilidad',
                color: Colors.teal,
              ),
              const SizedBox(height: 8),
              _StatGroupCard(
                title: 'Estructura del backend',
                stats: [
                  _StatItem(
                    'Controladores',
                    '${summary.maintainability.totalControllers}',
                  ),
                  _StatItem(
                    'Servicios',
                    '${summary.maintainability.totalServices}',
                  ),
                  _StatItem(
                    'Repositorios',
                    '${summary.maintainability.totalRepositories}',
                  ),
                  _StatItem(
                    'Gate JaCoCo',
                    '${summary.maintainability.jacocoCoverageGatePercent}%',
                  ),
                  _StatItem(
                    'Errores estandarizados',
                    summary.maintainability.standardizedErrorHandlingEnabled
                        ? 'Sí'
                        : 'No',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _SectionHeader(
                icon: Icons.calendar_month_rounded,
                title: 'Citas',
                color: Colors.deepOrange,
              ),
              const SizedBox(height: 8),
              _StatGroupCard(
                title: 'Calidad operacional',
                stats: [
                  _StatItem(
                    'Intentos de creación',
                    '${summary.appointments.totalCreationAttempts}',
                  ),
                  _StatItem(
                    'Citas exitosas',
                    '${summary.appointments.successfulAppointments}',
                  ),
                  _StatItem(
                    'Rechazadas',
                    '${summary.appointments.rejectedByBusinessRules}',
                  ),
                  _StatItem(
                    'Cumplimiento reglas',
                    '${summary.appointments.businessRuleCompliancePercent.toStringAsFixed(2)}%',
                  ),
                  _StatItem(
                    'Integridad de datos',
                    '${summary.appointments.dataIntegrityPercent.toStringAsFixed(2)}%',
                  ),
                  _StatItem(
                    'Registros válidos',
                    '${summary.appointments.validRecordsInDB}/${summary.appointments.totalAppointmentsInDB}',
                  ),
                ],
              ),
            ],
          ),
          loading: () => const LoadingWidget(message: 'Cargando métricas...'),
          error: (e, _) => AppErrorWidget(
            message: e.toString(),
            onRetry: () =>
                ref.read(adminMetricsNotifierProvider.notifier).refresh(),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  final PerformanceMetricsEntity metric;

  const _PerformanceCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              metric.endpoint,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _ChipStat(
                  label: 'Promedio',
                  value: '${metric.avgResponseTimeMs} ms',
                ),
                _ChipStat(label: 'Total', value: '${metric.totalRequests}'),
                _ChipStat(
                  label: 'Bajo umbral',
                  value: '${metric.requestsUnderThreshold}',
                ),
                _ChipStat(
                  label: 'Cumplimiento',
                  value: '${metric.compliancePercent.toStringAsFixed(2)}%',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatGroupCard extends StatelessWidget {
  final String title;
  final List<_StatItem> stats;

  const _StatGroupCard({required this.title, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ...stats.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Expanded(child: Text(item.label)),
                    Text(
                      item.value,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipStat extends StatelessWidget {
  final String label;
  final String value;

  const _ChipStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Text('$label: $value'),
    );
  }
}

class _StatItem {
  final String label;
  final String value;

  const _StatItem(this.label, this.value);
}
