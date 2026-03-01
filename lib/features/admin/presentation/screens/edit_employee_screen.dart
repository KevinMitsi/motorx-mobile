import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/admin_provider.dart';

/// Screen to edit an existing employee (position + state).
class EditEmployeeScreen extends ConsumerStatefulWidget {
  final int employeeId;

  const EditEmployeeScreen({super.key, required this.employeeId});

  @override
  ConsumerState<EditEmployeeScreen> createState() =>
      _EditEmployeeScreenState();
}

class _EditEmployeeScreenState
    extends ConsumerState<EditEmployeeScreen> {
  String? _position;
  String? _employeeState;
  bool _isLoading = false;
  bool _initialized = false;

  Future<void> _submit() async {
    if (_position == null || _employeeState == null) return;
    setState(() => _isLoading = true);

    try {
      await ref.read(adminEmployeeNotifierProvider.notifier).updateEmployee(
            id: widget.employeeId,
            position: _position!,
            employeeState: _employeeState!,
          );

      if (!mounted) return;
      context.showSnackBar('Empleado actualizado');
      context.pop();
    } catch (e) {
      if (mounted) context.showSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeesState = ref.watch(adminEmployeeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.editEmployee),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      body: employeesState.when(
        data: (employees) {
          final emp = employees
              .where((e) => e.employeeId == widget.employeeId)
              .firstOrNull;
          if (emp == null) {
            return const Center(child: Text('Empleado no encontrado'));
          }

          if (!_initialized) {
            _position = emp.position;
            _employeeState = emp.state;
            _initialized = true;
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Read-only info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(emp.userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(emp.userEmail),
                          Text('DNI: ${emp.userDni}'),
                          Text('Tel: ${emp.userPhone}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  DropdownButtonFormField<String>(
                    value: _position,
                    decoration: const InputDecoration(
                      labelText: 'Cargo',
                      prefixIcon: Icon(Icons.badge_rounded),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'MECANICO', child: Text('Mecánico')),
                      DropdownMenuItem(
                          value: 'RECEPCIONISTA',
                          child: Text('Recepcionista')),
                    ],
                    onChanged: (v) => setState(() => _position = v),
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _employeeState,
                    decoration: const InputDecoration(
                      labelText: 'Estado',
                      prefixIcon: Icon(Icons.toggle_on_rounded),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'AVAILABLE', child: Text('Disponible')),
                      DropdownMenuItem(
                          value: 'NOT_AVAILABLE',
                          child: Text('No disponible')),
                    ],
                    onChanged: (v) =>
                        setState(() => _employeeState = v),
                  ),
                  const SizedBox(height: 32),

                  AppButton(
                    label: AppStrings.save,
                    onPressed: _submit,
                    isLoading: _isLoading,
                    icon: Icons.save_rounded,
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}
