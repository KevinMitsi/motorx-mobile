import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/vehicle_provider.dart';

/// Screen to register a new vehicle.
class AddVehicleScreen extends ConsumerStatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  ConsumerState<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends ConsumerState<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateController = TextEditingController();
  final _ccController = TextEditingController();
  final _chassisController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    _ccController.dispose();
    _chassisController.dispose();
    super.dispose();
  }

  Future<void> _handleCreate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(vehicleListNotifierProvider.notifier).createVehicle(
            brand: _brandController.text.trim(),
            model: _modelController.text.trim(),
            yearOfManufacture: int.parse(_yearController.text.trim()),
            licensePlate: _plateController.text.trim().toUpperCase(),
            cylinderCapacity: int.parse(_ccController.text.trim()),
            chassisNumber: _chassisController.text.trim(),
          );

      if (!mounted) return;
      context.showSnackBar('Vehículo registrado exitosamente');
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
        title: const Text(AppStrings.addVehicle),
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
                  controller: _brandController,
                  label: AppStrings.brand,
                  hint: 'Yamaha',
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: const Icon(Icons.branding_watermark_outlined),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _modelController,
                  label: AppStrings.model,
                  hint: 'FZ 250',
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: const Icon(Icons.directions_bike_rounded),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _yearController,
                  label: AppStrings.year,
                  hint: '2024',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.isEmpty) return AppStrings.fieldRequired;
                    final year = int.tryParse(v);
                    if (year == null || year < 1950 || year > 2026) {
                      return 'Año debe estar entre 1950 y 2026';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _plateController,
                  label: AppStrings.licensePlate,
                  hint: 'ABC12D',
                  textCapitalization: TextCapitalization.characters,
                  prefixIcon: const Icon(Icons.pin_outlined),
                  validator: (v) {
                    if (v == null || v.isEmpty) return AppStrings.fieldRequired;
                    if (!v.toUpperCase().isValidColombianPlate) {
                      return AppStrings.invalidPlate;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _ccController,
                  label: AppStrings.cylinderCapacity,
                  hint: '250',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.speed_rounded),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.isEmpty) return AppStrings.fieldRequired;
                    final cc = int.tryParse(v);
                    if (cc == null || cc < 50 || cc > 9999) {
                      return 'Cilindraje entre 50 y 9999 cc';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _chassisController,
                  label: AppStrings.chassisNumber,
                  hint: '9C6KE091080123456',
                  textCapitalization: TextCapitalization.characters,
                  prefixIcon: const Icon(Icons.qr_code_2_rounded),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? AppStrings.fieldRequired : null,
                ),
                const SizedBox(height: 32),
                AppButton(
                  label: AppStrings.save,
                  onPressed: _handleCreate,
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
