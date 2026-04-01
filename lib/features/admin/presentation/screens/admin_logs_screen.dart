import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/admin_entities.dart';
import '../providers/admin_provider.dart';

/// Admin screen to inspect paginated audit logs.
class AdminLogsScreen extends ConsumerStatefulWidget {
  const AdminLogsScreen({super.key});

  @override
  ConsumerState<AdminLogsScreen> createState() => _AdminLogsScreenState();
}

class _AdminLogsScreenState extends ConsumerState<AdminLogsScreen> {
  static const int _pageSize = 20;
  static const String _sort = 'createdAt,desc';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(adminLogsNotifierProvider.notifier)
          .fetchLogs(page: 0, size: _pageSize, sort: _sort);
    });
  }

  @override
  Widget build(BuildContext context) {
    final logsState = ref.watch(adminLogsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.adminLogs),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline_rounded, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Mostrando logs paginados ($_pageSize por página, ordenados por fecha desc).',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: logsState.when(
              data: (page) {
                if (page.empty || page.content.isEmpty) {
                  return const Center(child: Text('No hay logs registrados'));
                }

                return Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => ref
                            .read(adminLogsNotifierProvider.notifier)
                            .refresh(),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: page.content.length,
                          itemBuilder: (context, index) {
                            final log = page.content[index];
                            return _LogCard(log: log);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: page.first
                                  ? null
                                  : () => ref
                                        .read(
                                          adminLogsNotifierProvider.notifier,
                                        )
                                        .previousPage(),
                              icon: const Icon(Icons.chevron_left_rounded),
                              label: const Text('Anterior'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('Página ${page.page + 1} de ${page.totalPages}'),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: page.last
                                  ? null
                                  : () => ref
                                        .read(
                                          adminLogsNotifierProvider.notifier,
                                        )
                                        .nextPage(),
                              icon: const Icon(Icons.chevron_right_rounded),
                              label: const Text('Siguiente'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const LoadingWidget(message: 'Cargando logs...'),
              error: (e, _) => AppErrorWidget(
                message: e.toString(),
                onRetry: () =>
                    ref.read(adminLogsNotifierProvider.notifier).refresh(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  final AdminLogEntity log;

  const _LogCard({required this.log});

  @override
  Widget build(BuildContext context) {
    final isSuccess = log.result == 'SUCCESS';
    final color = isSuccess
        ? Colors.green
        : Theme.of(context).colorScheme.error;
    final createdAt = DateTime.tryParse(log.createdAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    log.result,
                    style: TextStyle(color: color, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${log.serviceName} · ${log.actionType}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text('#${log.id}'),
              ],
            ),
            const SizedBox(height: 8),
            Text(log.message),
            const SizedBox(height: 8),
            Text(
              'Actor: ${log.actorEmail ?? 'N/A'}${log.actorUserId != null ? ' (ID ${log.actorUserId})' : ''}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 2),
            Text(
              'Fecha: ${createdAt != null ? DateFormat('dd/MM/yyyy HH:mm').format(createdAt) : log.createdAt}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
