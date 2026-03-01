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
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  validator: (v) {
                    if (v == null || v.isEmpty) return AppStrings.fieldRequired;
                    if (v.length < 6) return AppStrings.passwordTooShort;
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _phoneController,
                  label: AppStrings.phone,
                  hint: '+57 300 1234567',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
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
