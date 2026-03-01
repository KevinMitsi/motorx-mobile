import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/vehicle_provider.dart';

/// Detail screen for a vehicle with edit/delete actions.
class VehicleDetailScreen extends ConsumerWidget {
  final int vehicleId;

  const VehicleDetailScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesState = ref.watch(vehicleListNotifierProvider);
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Vehículo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () => context.push('/vehicles/edit/$vehicleId'),
            tooltip: AppStrings.edit,
          ),
          IconButton(
            icon: Icon(Icons.delete_rounded, color: colorScheme.error),
            onPressed: () => _confirmDelete(context, ref),
            tooltip: AppStrings.delete,
          ),
        ],
      ),
      body: vehiclesState.when(
        data: (vehicles) {
          final vehicle =
              vehicles.where((v) => v.id == vehicleId).firstOrNull;
          if (vehicle == null) {
            return const Center(child: Text('Vehículo no encontrado'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Hero icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    Icons.motorcycle_rounded,
                    size: 48,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${vehicle.brand} ${vehicle.model}',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Chip(
                  label: Text(vehicle.licensePlate),
                  avatar: const Icon(Icons.pin_outlined, size: 16),
                ),
                const SizedBox(height: 24),

                // Details card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _DetailRow(
                          icon: Icons.branding_watermark_outlined,
                          label: AppStrings.brand,
                          value: vehicle.brand,
                        ),
                        const Divider(height: 24),
                        _DetailRow(
                          icon: Icons.directions_bike_rounded,
                          label: AppStrings.model,
                          value: vehicle.model,
                        ),
                        const Divider(height: 24),
                        _DetailRow(
                          icon: Icons.calendar_today_outlined,
                          label: AppStrings.year,
                          value: vehicle.yearOfManufacture.toString(),
                        ),
                        const Divider(height: 24),
                        _DetailRow(
                          icon: Icons.speed_rounded,
                          label: AppStrings.cylinderCapacity,
                          value: '${vehicle.cylinderCapacity} cc',
                        ),
                        const Divider(height: 24),
                        _DetailRow(
                          icon: Icons.qr_code_2_rounded,
                          label: AppStrings.chassisNumber,
                          value: vehicle.chassisNumber,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.deleteVehicle),
        content: const Text(AppStrings.deleteVehicleConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await ref
                    .read(vehicleListNotifierProvider.notifier)
                    .deleteVehicle(vehicleId);
                if (context.mounted) {
                  context.showSnackBar('Vehículo eliminado');
                  context.pop();
                }
              } catch (e) {
                if (context.mounted) {
                  context.showSnackBar(e.toString(), isError: true);
                }
              }
            },
            child: Text(
              AppStrings.delete,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: '$label: $value',
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
