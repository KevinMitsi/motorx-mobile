import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/admin_provider.dart';

/// Admin employee list screen.
class EmployeesScreen extends ConsumerWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesState = ref.watch(adminEmployeeNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.employees),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/employees/create'),
        icon: const Icon(Icons.add_rounded),
        label: const Text(AppStrings.createEmployee),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(adminEmployeeNotifierProvider.notifier).refresh(),
        child: employeesState.when(
          data: (employees) {
            if (employees.isEmpty) {
              return const Center(
                child: Text('No hay empleados registrados'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final e = employees[index];
                final posLabel =
                    AppStrings.employeePositionLabels[e.position] ??
                        e.position;
                final stateLabel =
                    AppStrings.employeeStateLabels[e.state] ?? e.state;
                final isAvailable = e.state == 'AVAILABLE';

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isAvailable
                          ? Colors.green.withValues(alpha: 0.15)
                          : Colors.grey.withValues(alpha: 0.15),
                      child: Icon(
                        Icons.engineering_rounded,
                        color: isAvailable ? Colors.green : Colors.grey,
                      ),
                    ),
                    title: Text(
                      e.userName,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('$posLabel · $stateLabel'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (action) =>
                          _handleAction(context, ref, action, e.employeeId),
                      itemBuilder: (ctx) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text(AppStrings.edit),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text(
                            AppStrings.delete,
                            style: TextStyle(color: colorScheme.error),
                          ),
                        ),
                      ],
                    ),
                    onTap: () =>
                        context.push('/admin/employees/edit/${e.employeeId}'),
                  ),
                );
              },
            );
          },
          loading: () =>
              const LoadingWidget(message: 'Cargando empleados...'),
          error: (e, _) => AppErrorWidget(
            message: e.toString(),
            onRetry: () =>
                ref.read(adminEmployeeNotifierProvider.notifier).refresh(),
          ),
        ),
      ),
    );
  }

  void _handleAction(
      BuildContext context, WidgetRef ref, String action, int id) {
    switch (action) {
      case 'edit':
        context.push('/admin/employees/edit/$id');
        break;
      case 'delete':
        _confirmDelete(context, ref, id);
        break;
    }
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Empleado'),
        content: const Text(
            '¿Estás seguro? Se eliminará el empleado y su cuenta de usuario.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await ref
                    .read(adminEmployeeNotifierProvider.notifier)
                    .deleteEmployee(id);
                if (context.mounted) {
                  context.showSnackBar('Empleado eliminado');
                }
              } catch (e) {
                if (context.mounted) {
                  context.showSnackBar(e.toString(), isError: true);
                }
              }
            },
            child: Text(
              AppStrings.delete,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
