import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../vehicles/domain/entities/vehicle_entity.dart';
import '../../../vehicles/presentation/providers/vehicle_provider.dart';
import '../providers/appointment_provider.dart';

/// Multi-step form to create an appointment.
/// Flow: select vehicle → check plate → select type → select date →
/// fetch slots → select time → enter mileage → optional notes → submit.
class CreateAppointmentScreen extends ConsumerStatefulWidget {
  const CreateAppointmentScreen({super.key});

  @override
  ConsumerState<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState
    extends ConsumerState<CreateAppointmentScreen> {
  int _step = 0;

  // Step 0: Vehicle selection
  VehicleEntity? _selectedVehicle;

  // Step 1: Appointment type
  String? _selectedType;

  // Step 2: Date + check restriction
  DateTime? _selectedDate;
  bool _isCheckingRestriction = false;

  // Step 3: Time slot
  String? _selectedSlotStart;
  String? _selectedSlotEnd;

  // Step 4: Mileage + notes
  final _mileageController = TextEditingController();
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  /// User-selectable appointment types (excludes UNPLANNED and REWORK).
  static const _bookableTypes = [
    'MANUAL_WARRANTY_REVIEW',
    'AUTECO_WARRANTY',
    'QUICK_SERVICE',
    'MAINTENANCE',
    'OIL_CHANGE',
  ];

  @override
  void dispose() {
    _mileageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _goBack() {
    if (_step > 0) {
      setState(() {
        if (_step == 3) {
          _selectedSlotStart = null;
          _selectedSlotEnd = null;
          ref.read(availableSlotsNotifierProvider.notifier).clear();
        }
        _step--;
      });
    } else {
      context.pop();
    }
  }

  void _selectVehicle(VehicleEntity vehicle) {
    setState(() {
      _selectedVehicle = vehicle;
      _step = 1;
    });
  }

  void _selectType(String type) {
    // If REWORK, show info page instead of continuing
    setState(() {
      _selectedType = type;
      _step = 2;
    });
  }

  Future<void> _selectDate(DateTime date) async {
    setState(() {
      _selectedDate = date;
      _isCheckingRestriction = true;
    });

    // Check plate restriction
    final restriction =
        await ref.read(plateRestrictionNotifierProvider.notifier).check(
              vehicleId: _selectedVehicle!.id,
              date: date.toApiDate(),
            );

    if (!mounted) return;
    setState(() => _isCheckingRestriction = false);

    if (restriction != null && restriction.isRestricted) {
      // Show restriction dialog
      _showRestrictionDialog(restriction);
    } else {
      // Start fetching available slots and advance to step 3 so the
      // UI becomes a listener (prevents AutoDispose providers from
      // being disposed while the network call completes).
      ref.read(availableSlotsNotifierProvider.notifier).fetchSlots(
        date: date.toApiDate(),
        type: _selectedType!,
      );
      setState(() => _step = 3);
    }
  }

  void _showRestrictionDialog(dynamic restriction) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: Icon(Icons.warning_rounded,
            color: Theme.of(context).colorScheme.error, size: 40),
        title: const Text('Restricción de Movilidad'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(restriction.message),
            if (restriction.urgentContactMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                restriction.urgentContactMessage!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (restriction.phoneNumber != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone, size: 16),
                  const SizedBox(width: 8),
                  Text(restriction.phoneNumber!),
                ],
              ),
            ],
            if (restriction.businessHours != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.schedule, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(restriction.businessHours!)),
                ],
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _selectedDate = null;
              });
            },
            child: const Text('Elegir otra fecha'),
          ),
        ],
      ),
    );
  }

  void _selectSlot(String start, String end) {
    setState(() {
      _selectedSlotStart = start;
      _selectedSlotEnd = end;
      _step = 4;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final notes = _notesController.text.trim();
      await ref
          .read(appointmentListNotifierProvider.notifier)
          .createAppointment(
            vehicleId: _selectedVehicle!.id,
            appointmentType: _selectedType!,
            appointmentDate: _selectedDate!.toApiDate(),
            startTime: _selectedSlotStart!,
            currentMileage: int.parse(_mileageController.text.trim()),
            clientNotes: notes.isNotEmpty ? [notes] : null,
          );

      if (!mounted) return;
      context.showSnackBar('¡Cita agendada exitosamente!');
      context.pop();
    } catch (e) {
      if (mounted) context.showSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Keep the AutoDispose provider alive throughout this screen so that
    // the async network result is not discarded before _SlotSelectionStep
    // gets a chance to subscribe (Riverpod disposes on microtask when there
    // are zero listeners, which can happen between fetchSlots() and the next
    // frame where the step-3 widget registers its ref.watch).
    ref.watch(availableSlotsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Cita'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _goBack,
          tooltip: 'Volver',
        ),
      ),
      body: Column(
        children: [
          // Step indicator
          _StepIndicator(currentStep: _step, colorScheme: colorScheme),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _buildStep(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep() => switch (_step) {
        0 => _VehicleSelectionStep(
            key: const ValueKey(0),
            ref: ref,
            onSelect: _selectVehicle,
          ),
        1 => _TypeSelectionStep(
            key: const ValueKey(1),
            types: _bookableTypes,
            onSelect: _selectType,
          ),
        2 => _DateSelectionStep(
            key: const ValueKey(2),
            isLoading: _isCheckingRestriction,
            onSelect: _selectDate,
          ),
        3 => _SlotSelectionStep(
            key: const ValueKey(3),
            ref: ref,
            onSelect: _selectSlot,
          ),
        4 => _DetailsStep(
            key: const ValueKey(4),
            formKey: _formKey,
            mileageController: _mileageController,
            notesController: _notesController,
            isSubmitting: _isSubmitting,
            vehicleName:
                '${_selectedVehicle?.brand} ${_selectedVehicle?.model}',
            typeName: AppStrings.appointmentTypeLabels[_selectedType] ?? '',
            date: _selectedDate?.toReadableDate() ?? '',
            time: '$_selectedSlotStart — $_selectedSlotEnd',
            onSubmit: _submit,
          ),
        _ => const SizedBox.shrink(),
      };
}

// ── Step Indicator ──────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final ColorScheme colorScheme;

  const _StepIndicator({required this.currentStep, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    const labels = ['Vehículo', 'Tipo', 'Fecha', 'Horario', 'Detalles'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: List.generate(labels.length, (i) {
          final isActive = i <= currentStep;
          return Expanded(
            child: Column(
              children: [
                Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isActive
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  labels[i],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isActive
                            ? colorScheme.primary
                            : colorScheme.onSurface.withValues(alpha: 0.4),
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.normal,
                      ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ── Step 0: Vehicle Selection ───────────────────────────────

class _VehicleSelectionStep extends StatelessWidget {
  final WidgetRef ref;
  final ValueChanged<VehicleEntity> onSelect;

  const _VehicleSelectionStep({
    super.key,
    required this.ref,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final vehiclesState = ref.watch(vehicleListNotifierProvider);

    return vehiclesState.when(
      data: (vehicles) {
        if (vehicles.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.motorcycle_rounded, size: 48),
                  const SizedBox(height: 16),
                  const Text('Primero registra un vehículo'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.push('/vehicles/add'),
                    child: const Text(AppStrings.addVehicle),
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final v = vehicles[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.motorcycle_rounded,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                title: Text('${v.brand} ${v.model}'),
                subtitle: Text('${v.licensePlate} · ${v.yearOfManufacture}'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => onSelect(v),
              ),
            );
          },
        );
      },
      loading: () => const LoadingWidget(),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}

// ── Step 1: Type Selection ──────────────────────────────────

class _TypeSelectionStep extends StatelessWidget {
  final List<String> types;
  final ValueChanged<String> onSelect;

  const _TypeSelectionStep({
    super.key,
    required this.types,
    required this.onSelect,
  });

  IconData _icon(String type) => switch (type) {
        'OIL_CHANGE' => Icons.oil_barrel_rounded,
        'QUICK_SERVICE' => Icons.flash_on_rounded,
        'MAINTENANCE' => Icons.build_rounded,
        'MANUAL_WARRANTY_REVIEW' => Icons.menu_book_rounded,
        'AUTECO_WARRANTY' => Icons.verified_rounded,
        _ => Icons.calendar_month_rounded,
      };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: types.length,
      itemBuilder: (context, index) {
        final type = types[index];
        final label = AppStrings.appointmentTypeLabels[type] ?? type;
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.secondaryContainer,
              child: Icon(
                _icon(type),
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            title: Text(label),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => onSelect(type),
          ),
        );
      },
    );
  }
}

// ── Step 2: Date Selection ──────────────────────────────────

class _DateSelectionStep extends StatelessWidget {
  final bool isLoading;
  final ValueChanged<DateTime> onSelect;

  const _DateSelectionStep({
    super.key,
    required this.isLoading,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingWidget(message: 'Verificando restricciones...');
    }

    final now = DateTime.now();
    return CalendarDatePicker(
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now.add(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 90)),
      onDateChanged: onSelect,
    );
  }
}

// ── Step 3: Slot Selection ──────────────────────────────────

class _SlotSelectionStep extends StatelessWidget {
  final WidgetRef ref;
  final void Function(String start, String end) onSelect;

  const _SlotSelectionStep({
    super.key,
    required this.ref,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final slotsState = ref.watch(availableSlotsNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return slotsState.when(
      data: (slotsData) {
        if (slotsData == null || slotsData.availableSlots.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                'No hay horarios disponibles para esta fecha y tipo de servicio. '
                'Intenta con otra fecha.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: slotsData.availableSlots.length,
          itemBuilder: (context, index) {
            final slot = slotsData.availableSlots[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.tertiaryContainer,
                  child: Icon(
                    Icons.access_time_rounded,
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
                title: Text('${slot.startTime} — ${slot.endTime}'),
                subtitle: Text(
                    '${slot.availableTechnicians} técnico(s) disponible(s)'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => onSelect(slot.startTime, slot.endTime),
              ),
            );
          },
        );
      },
      loading: () =>
          const LoadingWidget(message: 'Buscando horarios disponibles...'),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}

// ── Step 4: Mileage + Notes + Submit ────────────────────────

class _DetailsStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController mileageController;
  final TextEditingController notesController;
  final bool isSubmitting;
  final String vehicleName;
  final String typeName;
  final String date;
  final String time;
  final VoidCallback onSubmit;

  const _DetailsStep({
    super.key,
    required this.formKey,
    required this.mileageController,
    required this.notesController,
    required this.isSubmitting,
    required this.vehicleName,
    required this.typeName,
    required this.date,
    required this.time,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Summary card
            Card(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resumen de la cita',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    _SummaryRow(label: 'Vehículo', value: vehicleName),
                    _SummaryRow(label: 'Servicio', value: typeName),
                    _SummaryRow(label: 'Fecha', value: date),
                    _SummaryRow(label: 'Horario', value: time),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            AppTextField(
              controller: mileageController,
              label: AppStrings.currentMileage,
              hint: '15000',
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.speed_rounded),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) {
                if (v == null || v.isEmpty) return AppStrings.fieldRequired;
                final km = int.tryParse(v);
                if (km == null || km < 0) return 'Kilometraje inválido';
                return null;
              },
            ),
            const SizedBox(height: 16),

            AppTextField(
              controller: notesController,
              label: AppStrings.clientNotes,
              hint: 'Ej: Ruido extraño en el motor',
              maxLines: 3,
              prefixIcon: const Icon(Icons.notes_rounded),
            ),
            const SizedBox(height: 32),

            AppButton(
              label: 'Confirmar Cita',
              onPressed: onSubmit,
              isLoading: isSubmitting,
              icon: Icons.check_circle_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
