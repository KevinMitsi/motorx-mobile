import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';

import '../providers/admin_provider.dart';

/// Screen for admin to register an unplanned appointment.
class UnplannedAppointmentScreen extends ConsumerStatefulWidget {
  const UnplannedAppointmentScreen({super.key});

  @override
  ConsumerState<UnplannedAppointmentScreen> createState() =>
      _UnplannedAppointmentScreenState();
}

class _UnplannedAppointmentScreenState
    extends ConsumerState<UnplannedAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleIdController = TextEditingController();
  final _mileageController = TextEditingController();
  final _technicianIdController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _vehicleIdController.dispose();
    _mileageController.dispose();
    _technicianIdController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null || _selectedTime == null) {
      context.showSnackBar('Selecciona fecha y hora', isError: true);
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final ds = ref.read(adminDatasourceProvider);
      await ds.createUnplannedAppointment(
        vehicleId: int.parse(_vehicleIdController.text.trim()),
        appointmentDate: _selectedDate!.toApiDate(),
        startTime: _selectedTime!.toApiTime(),
        currentMileage: int.parse(_mileageController.text.trim()),
        technicianId: _technicianIdController.text.trim().isNotEmpty
            ? int.tryParse(_technicianIdController.text.trim())
            : null,
        adminNotes: _notesController.text.trim().isNotEmpty
            ? _notesController.text.trim()
            : null,
      );

      if (!mounted) return;
      context.showSnackBar('Cita no planeada registrada exitosamente');
      context.pop();
    } catch (e) {
      if (mounted) context.showSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.unplannedAppointment),
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
                AppTextField(
                  controller: _vehicleIdController,
                  label: 'ID del Vehículo',
                  hint: '5',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.motorcycle_rounded),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) =>
                      (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
                ),
                const SizedBox(height: 16),

                // Date picker
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  leading: const Icon(Icons.calendar_today_rounded),
                  title: Text(_selectedDate != null
                      ? _selectedDate!.toReadableDate()
                      : 'Seleccionar fecha'),
                  onTap: _pickDate,
                ),
                const SizedBox(height: 16),

                // Time picker
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  leading: const Icon(Icons.access_time_rounded),
                  title: Text(_selectedTime != null
                      ? _selectedTime!.toDisplayTime(context)
                      : 'Seleccionar hora'),
                  onTap: _pickTime,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _mileageController,
                  label: AppStrings.currentMileage,
                  hint: '12000',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.speed_rounded),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) =>
                      (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _technicianIdController,
                  label: 'ID del Técnico (opcional)',
                  hint: 'Dejar vacío para asignación automática',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.engineering_rounded),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _notesController,
                  label: 'Notas del admin',
                  hint: 'Motivo o comentarios',
                  maxLines: 3,
                  prefixIcon: const Icon(Icons.notes_rounded),
                ),
                const SizedBox(height: 32),

                AppButton(
                  label: 'Registrar Cita',
                  onPressed: _submit,
                  isLoading: _isSubmitting,
                  icon: Icons.add_circle_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
