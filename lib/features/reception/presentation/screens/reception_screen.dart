import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/reception_provider.dart';

class ReceptionScreen extends ConsumerStatefulWidget {
  const ReceptionScreen({super.key});

  @override
  ConsumerState<ReceptionScreen> createState() => _ReceptionScreenState();
}

class _ReceptionScreenState extends ConsumerState<ReceptionScreen> {
  final _initiateFormKey = GlobalKey<FormState>();
  final _confirmFormKey = GlobalKey<FormState>();
  final _appointmentIdCtrl = TextEditingController();
  final _plateCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();

  @override
  void dispose() {
    _appointmentIdCtrl.dispose();
    _plateCtrl.dispose();
    _codeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(receptionNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Recepción de motos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _initiateFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1. Iniciar recepción',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        controller: _appointmentIdCtrl,
                        label: 'ID de cita',
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Campo requerido';
                          }
                          return int.tryParse(v.trim()) == null
                              ? 'ID inválido'
                              : null;
                        },
                      ),
                      const SizedBox(height: 12),
                      AppButton(
                        label: 'Enviar código',
                        isLoading: state.isLoading,
                        onPressed: () async {
                          if (!_initiateFormKey.currentState!.validate()) {
                            return;
                          }
                          try {
                            await ref
                                .read(receptionNotifierProvider.notifier)
                                .initiateReception(
                                  int.parse(_appointmentIdCtrl.text.trim()),
                                );
                            if (context.mounted) {
                              context.showSnackBar(
                                ref
                                        .read(receptionNotifierProvider)
                                        .lastMessage ??
                                    'Código enviado',
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              context.showSnackBar(e.toString(), isError: true);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _confirmFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2. Confirmar recepción',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        controller: _plateCtrl,
                        label: 'Placa',
                        textCapitalization: TextCapitalization.characters,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Campo requerido'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        controller: _codeCtrl,
                        label: 'Código de 4 dígitos',
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Campo requerido';
                          }
                          return RegExp(r'^\d{4}$').hasMatch(v.trim())
                              ? null
                              : 'Código inválido';
                        },
                      ),
                      const SizedBox(height: 12),
                      AppButton(
                        label: 'Confirmar recepción',
                        isLoading: state.isLoading,
                        onPressed: () async {
                          if (!_confirmFormKey.currentState!.validate()) return;
                          try {
                            await ref
                                .read(receptionNotifierProvider.notifier)
                                .confirmReception(
                                  vehiclePlate: _plateCtrl.text
                                      .trim()
                                      .toUpperCase(),
                                  code: _codeCtrl.text.trim(),
                                );
                            if (context.mounted) {
                              context.showSnackBar(
                                ref
                                        .read(receptionNotifierProvider)
                                        .lastMessage ??
                                    'Recepción confirmada',
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              context.showSnackBar(e.toString(), isError: true);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
