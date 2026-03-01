import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/vehicle_provider.dart';
import '../widgets/vehicle_card.dart';

/// Screen showing all user's registered vehicles.
class VehiclesScreen extends ConsumerWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesState = ref.watch(vehicleListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myVehicles),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addVehicle),
        icon: const Icon(Icons.add_rounded),
        label: const Text(AppStrings.addVehicle),
        tooltip: AppStrings.addVehicle,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(vehicleListNotifierProvider.notifier).refresh(),
        child: vehiclesState.when(
          data: (vehicles) {
            if (vehicles.isEmpty) {
              return EmptyStateWidget(
                title: AppStrings.noVehicles,
                subtitle: AppStrings.noVehiclesHint,
                icon: Icons.motorcycle_rounded,
                actionLabel: AppStrings.addVehicle,
                onAction: () => context.push(AppRoutes.addVehicle),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                return VehicleCard(
                  vehicle: vehicle,
                  onTap: () =>
                      context.push('/vehicles/${vehicle.id}'),
                );
              },
            );
          },
          loading: () => const LoadingWidget(message: 'Cargando vehículos...'),
          error: (e, _) => AppErrorWidget(
            message: e.toString(),
            onRetry: () =>
                ref.read(vehicleListNotifierProvider.notifier).refresh(),
          ),
        ),
      ),
    );
  }
}
