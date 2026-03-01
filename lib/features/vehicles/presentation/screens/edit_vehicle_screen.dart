import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/vehicle_provider.dart';

/// Screen to edit an existing vehicle (brand, model, cc only).
class EditVehicleScreen extends ConsumerStatefulWidget {
  final int vehicleId;

  const EditVehicleScreen({super.key, required this.vehicleId});

  @override
  ConsumerState<EditVehicleScreen> createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends ConsumerState<EditVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _ccController = TextEditingController();
  bool _isLoading = false;
  bool _initialized = false;

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _ccController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(vehicleListNotifierProvider.notifier).updateVehicle(
            id: widget.vehicleId,
            brand: _brandController.text.trim(),
            model: _modelController.text.trim(),
            cylinderCapacity: int.parse(_ccController.text.trim()),
          );

      if (!mounted) return;
      context.showSnackBar('Vehículo actualizado exitosamente');
      context.pop();
    } catch (e) {
      if (mounted) context.showSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehiclesState = ref.watch(vehicleListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.editVehicle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      body: vehiclesState.when(
        data: (vehicles) {
          final vehicle = vehicles.where((v) => v.id == widget.vehicleId).firstOrNull;
          if (vehicle == null) {
            return const Center(child: Text('Vehículo no encontrado'));
          }

          if (!_initialized) {
            _brandController.text = vehicle.brand;
            _modelController.text = vehicle.model;
            _ccController.text = vehicle.cylinderCapacity.toString();
            _initialized = true;
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
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
                            Text(
                              'Datos no modificables',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                            ),
                            const SizedBox(height: 8),
                            _ReadOnlyField(
                                label: 'Placa', value: vehicle.licensePlate),
                            _ReadOnlyField(
                                label: 'Año',
                                value: vehicle.yearOfManufacture.toString()),
                            _ReadOnlyField(
                                label: 'Chasis',
                                value: vehicle.chassisNumber),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    AppTextField(
                      controller: _brandController,
                      label: AppStrings.brand,
                      textCapitalization: TextCapitalization.words,
                      prefixIcon:
                          const Icon(Icons.branding_watermark_outlined),
                      validator: (v) => (v == null || v.isEmpty)
                          ? AppStrings.fieldRequired
                          : null,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _modelController,
                      label: AppStrings.model,
                      textCapitalization: TextCapitalization.words,
                      prefixIcon:
                          const Icon(Icons.directions_bike_rounded),
                      validator: (v) => (v == null || v.isEmpty)
                          ? AppStrings.fieldRequired
                          : null,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _ccController,
                      label: AppStrings.cylinderCapacity,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.speed_rounded),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return AppStrings.fieldRequired;
                        }
                        final cc = int.tryParse(v);
                        if (cc == null || cc < 50 || cc > 9999) {
                          return 'Cilindraje entre 50 y 9999 cc';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      label: AppStrings.save,
                      onPressed: _handleUpdate,
                      isLoading: _isLoading,
                      icon: Icons.save_rounded,
                    ),
                  ],
                ),
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

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;

  const _ReadOnlyField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
