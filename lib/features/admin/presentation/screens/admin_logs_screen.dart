import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/admin_entities.dart';
import '../providers/admin_provider.dart';

/// Admin screen to inspect paginated audit logs with filters.
class AdminLogsScreen extends ConsumerStatefulWidget {
  const AdminLogsScreen({super.key});

  @override
  ConsumerState<AdminLogsScreen> createState() => _AdminLogsScreenState();
}

class _AdminLogsScreenState extends ConsumerState<AdminLogsScreen> {
  static const _serviceOptions = <String>[
    'AUTHENTICATION',
    'USER',
    'PASSWORD_RESET',
    'APPOINTMENT',
    'VEHICLE',
    'ADMIN',
  ];

  static const _actionOptions = <String>[
    'LOGIN',
    'REGISTER',
    'LOGOUT',
    'VERIFY_2FA',
    'REFRESH_TOKEN',
    'PASSWORD_RESET_REQUEST',
    'PASSWORD_RESET_CONFIRM',
    'UPDATE_USER_PROFILE',
    'SCHEDULE_APPOINTMENT',
    'CANCEL_APPOINTMENT',
  ];

  static const _resultOptions = <String>['SUCCESS', 'FAILURE'];

  final _actorEmailController = TextEditingController();
  final _actorUserIdController = TextEditingController();

  String? _serviceName;
  String? _actionType;
  String? _result;
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adminLogsNotifierProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _actorEmailController.dispose();
    _actorUserIdController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selected == null) return;

    setState(() {
      if (isFrom) {
        _fromDate = DateTime(
          selected.year,
          selected.month,
          selected.day,
          0,
          0,
          0,
        );
      } else {
        _toDate = DateTime(
          selected.year,
          selected.month,
          selected.day,
          23,
          59,
          59,
        );
      }
    });
  }

  Future<void> _applyFilters() async {
    final actorEmail = _actorEmailController.text.trim();
    final actorUserIdRaw = _actorUserIdController.text.trim();

    await ref
        .read(adminLogsNotifierProvider.notifier)
        .fetchLogs(
          filters: AdminLogFilters(
            serviceName: _serviceName,
            actionType: _actionType,
            result: _result,
            actorEmail: actorEmail.isEmpty ? null : actorEmail,
            actorUserId: actorUserIdRaw.isEmpty
                ? null
                : int.tryParse(actorUserIdRaw),
            from: _fromDate?.toIso8601String(),
            to: _toDate?.toIso8601String(),
          ),
          page: 0,
          size: 20,
        );
  }

  Future<void> _resetFilters() async {
    setState(() {
      _serviceName = null;
      _actionType = null;
      _result = null;
      _fromDate = null;
      _toDate = null;
    });

    _actorEmailController.clear();
    _actorUserIdController.clear();

    await ref.read(adminLogsNotifierProvider.notifier).fetchLogs();
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
          _FiltersPanel(
            serviceName: _serviceName,
            actionType: _actionType,
            result: _result,
            fromDate: _fromDate,
            toDate: _toDate,
            serviceOptions: _serviceOptions,
            actionOptions: _actionOptions,
            resultOptions: _resultOptions,
            actorEmailController: _actorEmailController,
            actorUserIdController: _actorUserIdController,
            onServiceChanged: (v) => setState(() => _serviceName = v),
            onActionChanged: (v) => setState(() => _actionType = v),
            onResultChanged: (v) => setState(() => _result = v),
            onPickFromDate: () => _pickDate(isFrom: true),
            onPickToDate: () => _pickDate(isFrom: false),
            onApplyFilters: _applyFilters,
            onResetFilters: _resetFilters,
          ),
          Expanded(
            child: logsState.when(
              data: (page) {
                if (page.empty || page.content.isEmpty) {
                  return const Center(
                    child: Text('No hay logs para los filtros actuales'),
                  );
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

class _FiltersPanel extends StatelessWidget {
  final String? serviceName;
  final String? actionType;
  final String? result;
  final DateTime? fromDate;
  final DateTime? toDate;
  final List<String> serviceOptions;
  final List<String> actionOptions;
  final List<String> resultOptions;
  final TextEditingController actorEmailController;
  final TextEditingController actorUserIdController;
  final ValueChanged<String?> onServiceChanged;
  final ValueChanged<String?> onActionChanged;
  final ValueChanged<String?> onResultChanged;
  final VoidCallback onPickFromDate;
  final VoidCallback onPickToDate;
  final Future<void> Function() onApplyFilters;
  final Future<void> Function() onResetFilters;

  const _FiltersPanel({
    required this.serviceName,
    required this.actionType,
    required this.result,
    required this.fromDate,
    required this.toDate,
    required this.serviceOptions,
    required this.actionOptions,
    required this.resultOptions,
    required this.actorEmailController,
    required this.actorUserIdController,
    required this.onServiceChanged,
    required this.onActionChanged,
    required this.onResultChanged,
    required this.onPickFromDate,
    required this.onPickToDate,
    required this.onApplyFilters,
    required this.onResetFilters,
  });

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime? value) {
      if (value == null) return 'No seleccionado';
      return DateFormat('dd/MM/yyyy').format(value);
    }

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: serviceName,
                    decoration: const InputDecoration(labelText: 'Módulo'),
                    items: serviceOptions
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: onServiceChanged,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: result,
                    decoration: const InputDecoration(labelText: 'Resultado'),
                    items: resultOptions
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: onResultChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: actionType,
              decoration: const InputDecoration(labelText: 'Acción'),
              items: actionOptions
                  .map(
                    (value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
              onChanged: onActionChanged,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: actorEmailController,
              decoration: const InputDecoration(
                labelText: 'Actor email (parcial)',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: actorUserIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Actor userId'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onPickFromDate,
                    icon: const Icon(Icons.event_rounded),
                    label: Text('Desde: ${formatDate(fromDate)}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onPickToDate,
                    icon: const Icon(Icons.event_rounded),
                    label: Text('Hasta: ${formatDate(toDate)}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onApplyFilters,
                    icon: const Icon(Icons.filter_alt_rounded),
                    label: const Text('Aplicar filtros'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onResetFilters,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Limpiar'),
                  ),
                ),
              ],
            ),
          ],
        ),
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
