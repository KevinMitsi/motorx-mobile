import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/admin_provider.dart';

/// Admin vehicles list with transfer-ownership capability.
class AdminVehiclesScreen extends ConsumerWidget {
  const AdminVehiclesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesState = ref.watch(adminVehicleNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.allVehicles),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(adminVehicleNotifierProvider.notifier).refresh(),
        child: vehiclesState.when(
          data: (vehicles) {
            if (vehicles.isEmpty) {
              return const Center(
                child: Text('No hay vehículos registrados'),
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
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(Icons.motorcycle_rounded,
                          color: colorScheme.onPrimaryContainer),
                    ),
                    title: Text(
                      '${v.brand} ${v.model}',
                      style: textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      '${v.licensePlate} · Dueño: ${v.ownerName}'
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.swap_horiz_rounded),
                      tooltip: AppStrings.transferOwnership,
                      onPressed: () => _showTransferDialog(
                          context, ref, v.id, v.licensePlate),
                    ),
                  ),
                );
              },
            );
          },
          loading: () =>
              const LoadingWidget(message: 'Cargando vehículos...'),
          error: (e, _) => AppErrorWidget(
            message: e.toString(),
            onRetry: () =>
                ref.read(adminVehicleNotifierProvider.notifier).refresh(),
          ),
        ),
      ),
    );
  }

  void _showTransferDialog(
    BuildContext context,
    WidgetRef ref,
    int vehicleId,
    String plate,
  ) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.transferOwnership),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Transferir vehículo $plate a un nuevo propietario.'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'ID del nuevo propietario',
                prefixIcon: Icon(Icons.person_search_rounded),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () async {
              final newOwnerId = int.tryParse(controller.text.trim());
              if (newOwnerId == null) return;
              Navigator.pop(ctx);
              try {
                await ref
                    .read(adminVehicleNotifierProvider.notifier)
                    .transferOwnership(
                      vehicleId: vehicleId,
                      newOwnerId: newOwnerId,
                    );
                if (context.mounted) {
                  context.showSnackBar('Propiedad transferida');
                }
              } catch (e) {
                if (context.mounted) {
                  context.showSnackBar(e.toString(), isError: true);
                }
              }
            },
            child: const Text(AppStrings.confirm),
          ),
        ],
      ),
    );
  }
}
