import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/admin_provider.dart';

/// Screen to create a new employee.
class CreateEmployeeScreen extends ConsumerStatefulWidget {
  const CreateEmployeeScreen({super.key});

  @override
  ConsumerState<CreateEmployeeScreen> createState() =>
      _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState
    extends ConsumerState<CreateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dniController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  String _position = 'MECANICO';
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dniController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      await ref.read(adminEmployeeNotifierProvider.notifier).createEmployee(
            position: _position,
            name: _nameController.text.trim(),
            dni: _dniController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            phone: _phoneController.text.trim(),
          );

      if (!mounted) return;
      context.showSnackBar('Empleado creado exitosamente');
      context.pop();
    } catch (e) {
      if (mounted) context.showSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  bool _isPasswordValid(String v) =>
      v.length >= 8 &&
      v.contains(RegExp(r'[A-Z]')) &&
      v.contains(RegExp(r'[0-9]')) &&
      v.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.createEmployee),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Position dropdown
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
                  onChanged: (v) => setState(() => _position = v!),
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _nameController,
                  label: AppStrings.name,
                  hint: 'Carlos Mecánico',
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: const Icon(Icons.person_rounded),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _dniController,
                  label: AppStrings.dni,
                  hint: '9876543210',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.badge_outlined),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _emailController,
                  label: AppStrings.email,
                  hint: 'carlos@motorx.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (v) {
                    if (v == null || v.isEmpty) return AppStrings.fieldRequired;
                    if (!v.isValidEmail) return AppStrings.invalidEmail;
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _passwordController,
                  label: AppStrings.password,
                  hint: '••••••••',
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  onChanged: (_) => setState(() {}),
                  validator: (v) {
                    if (v == null || v.isEmpty) return AppStrings.fieldRequired;
                    if (!_isPasswordValid(v)) {
                      return 'La contraseña no cumple los requisitos de seguridad';
                    }
                    return null;
                  },
                ),
                _PasswordRequirementsWidget(
                    password: _passwordController.text),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _phoneController,
                  label: AppStrings.phone,
                  hint: '3001234567',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 4),
                  child: Text(
                    'Solo ingrese el número sin indicativo +57',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                  ),
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
        ),
      ),
    );
  }
}

// ── Password requirements helper ─────────────────────────────────────────────

class _PasswordRequirementsWidget extends StatelessWidget {
  final String password;
  const _PasswordRequirementsWidget({required this.password});

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();
    final checks = [
      _Req('Mínimo 8 caracteres', password.length >= 8),
      _Req('Al menos 1 mayúscula', password.contains(RegExp(r'[A-Z]'))),
      _Req('Al menos 1 número', password.contains(RegExp(r'[0-9]'))),
      _Req(
          'Al menos 1 símbolo (!@#\$...)',
          password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]'))),
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: checks
            .map((r) => _RequirementRow(r))
            .toList(),
      ),
    );
  }
}

class _Req {
  final String label;
  final bool met;
  const _Req(this.label, this.met);
}

class _RequirementRow extends StatelessWidget {
  final _Req req;
  const _RequirementRow(this.req, {super.key});

  @override
  Widget build(BuildContext context) {
    final color = req.met ? Colors.green : Theme.of(context).colorScheme.error;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            req.met ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 15,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            req.label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
