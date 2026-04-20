import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../data/models/spare_model.dart';
import '../providers/spare_provider.dart';

class SpareFormScreen extends ConsumerStatefulWidget {
  final SpareModel? spare;

  const SpareFormScreen({super.key, this.spare});

  @override
  ConsumerState<SpareFormScreen> createState() => _SpareFormScreenState();
}

class _SpareFormScreenState extends ConsumerState<SpareFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _savCodeController = TextEditingController();
  final _spareCodeController = TextEditingController();
  final _supplierController = TextEditingController();
  final _compatibleMotorcycleInputController = TextEditingController();
  final _quantityController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _warehouseLocationController = TextEditingController();
  final _stockThresholdController = TextEditingController();
  final List<String> _compatibleMotorcycles = [];
  bool _isOil = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final spare = widget.spare;
    if (spare != null) {
      _nameController.text = spare.name;
      _savCodeController.text = spare.savCode;
      _spareCodeController.text = spare.spareCode;
      _supplierController.text = spare.supplier;
      _compatibleMotorcycles
        ..clear()
        ..addAll(spare.compatibleMotorcycles);
      _quantityController.text = spare.quantity.toString();
      _purchasePriceController.text = spare.purchasePriceWithVat.toString();
      _warehouseLocationController.text = spare.warehouseLocation;
      _stockThresholdController.text = spare.stockThreshold.toString();
      _isOil = spare.isOil;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _savCodeController.dispose();
    _spareCodeController.dispose();
    _supplierController.dispose();
    _compatibleMotorcycleInputController.dispose();
    _quantityController.dispose();
    _purchasePriceController.dispose();
    _warehouseLocationController.dispose();
    _stockThresholdController.dispose();
    super.dispose();
  }

  void _addCompatibleMotorcycle([String? rawValue]) {
    final value = (rawValue ?? _compatibleMotorcycleInputController.text)
        .trim();
    if (value.isEmpty) return;

    final alreadyExists = _compatibleMotorcycles.any(
      (m) => m.toLowerCase() == value.toLowerCase(),
    );
    if (alreadyExists) {
      _compatibleMotorcycleInputController.clear();
      return;
    }

    setState(() {
      _compatibleMotorcycles.add(value);
      _compatibleMotorcycleInputController.clear();
    });
  }

  void _removeCompatibleMotorcycle(String value) {
    setState(() {
      _compatibleMotorcycles.remove(value);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final notifier = ref.read(spareNotifierProvider.notifier);
    final parsedQty = int.tryParse(_quantityController.text.trim()) ?? 0;
    final parsedPrice =
        double.tryParse(_purchasePriceController.text.trim()) ?? 0;
    final parsedThreshold =
        int.tryParse(_stockThresholdController.text.trim()) ?? 0;

    try {
      if (widget.spare == null) {
        await notifier.createSpare(
          name: _nameController.text.trim(),
          savCode: _savCodeController.text.trim(),
          spareCode: _spareCodeController.text.trim(),
          supplier: _supplierController.text.trim(),
          compatibleMotorcycles: List<String>.from(_compatibleMotorcycles),
          quantity: parsedQty,
          purchasePriceWithVat: parsedPrice,
          isOil: _isOil,
          warehouseLocation: _warehouseLocationController.text.trim(),
          stockThreshold: parsedThreshold,
        );
      } else {
        await notifier.updateSpare(
          id: widget.spare!.id,
          name: _nameController.text.trim(),
          savCode: _savCodeController.text.trim(),
          spareCode: _spareCodeController.text.trim(),
          supplier: _supplierController.text.trim(),
          compatibleMotorcycles: List<String>.from(_compatibleMotorcycles),
          quantity: parsedQty,
          purchasePriceWithVat: parsedPrice,
          isOil: _isOil,
          warehouseLocation: _warehouseLocationController.text.trim(),
          stockThreshold: parsedThreshold,
        );
      }

      if (!mounted) return;
      context.showSnackBar('Repuesto guardado correctamente');
      Navigator.pop(context);
    } catch (e) {
      if (mounted) context.showSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.spare != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar repuesto' : 'Nuevo repuesto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                controller: _nameController,
                label: 'Nombre',
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? AppStrings.fieldRequired
                    : null,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _savCodeController,
                label: 'Código SAV',
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? AppStrings.fieldRequired
                    : null,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _spareCodeController,
                label: 'Código interno',
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? AppStrings.fieldRequired
                    : null,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _supplierController,
                label: 'Proveedor',
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? AppStrings.fieldRequired
                    : null,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Compatibilidad',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _compatibleMotorcycleInputController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: _addCompatibleMotorcycle,
                      decoration: const InputDecoration(
                        hintText: 'Escribe una moto y presiona Enter',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _addCompatibleMotorcycle,
                      child: const Text('Agregar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_compatibleMotorcycles.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _compatibleMotorcycles
                        .map(
                          (m) => Chip(
                            label: Text(m),
                            onDeleted: () => _removeCompatibleMotorcycle(m),
                          ),
                        )
                        .toList(),
                  ),
                ),
              FormField<List<String>>(
                initialValue: _compatibleMotorcycles,
                validator: (_) => _compatibleMotorcycles.isEmpty
                    ? AppStrings.fieldRequired
                    : null,
                builder: (state) {
                  if (state.hasError) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.errorText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _quantityController,
                label: 'Cantidad',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return AppStrings.fieldRequired;
                  }
                  if (int.tryParse(v.trim()) == null) {
                    return 'Cantidad inválida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _purchasePriceController,
                label: 'Precio compra (IVA)',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return AppStrings.fieldRequired;
                  }
                  if (double.tryParse(v.trim()) == null) {
                    return 'Precio inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _warehouseLocationController,
                label: 'Ubicación bodega (00-00-00-00)',
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return AppStrings.fieldRequired;
                  }
                  final ok = RegExp(
                    r'^\d{2}-\d{2}-\d{2}-\d{2}$',
                  ).hasMatch(v.trim());
                  return ok ? null : 'Formato inválido';
                },
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _stockThresholdController,
                label: 'Umbral mínimo',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return AppStrings.fieldRequired;
                  }
                  if (int.tryParse(v.trim()) == null) {
                    return 'Umbral inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _isOil,
                onChanged: (v) => setState(() => _isOil = v),
                title: const Text('¿Es aceite?'),
              ),
              const SizedBox(height: 20),
              AppButton(
                label: AppStrings.save,
                isLoading: _isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
