import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../providers/inventory_metrics_provider.dart';

class AdminInventoryMetricsScreen extends ConsumerWidget {
  const AdminInventoryMetricsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(inventoryMetricsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Métricas de inventario')),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(inventoryMetricsNotifierProvider.notifier).load(),
        child: state.isLoading
            ? const LoadingWidget(message: 'Cargando métricas de inventario...')
            : state.error != null
            ? AppErrorWidget(
                message: state.error!,
                onRetry: () =>
                    ref.read(inventoryMetricsNotifierProvider.notifier).load(),
              )
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (state.profit != null)
                    Card(
                      child: ListTile(
                        title: const Text('Ganancia estimada'),
                        subtitle: Text(
                          '${state.profit!.startDate} a ${state.profit!.endDate}',
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Unidades: ${state.profit!.totalUnitsSold}'),
                            Text(
                              'Ventas: ${state.profit!.grossSalesAmount.toStringAsFixed(0)}',
                            ),
                            Text(
                              'Ganancia: ${state.profit!.estimatedProfitAmount.toStringAsFixed(0)}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (state.belowThreshold != null)
                    Card(
                      child: ListTile(
                        title: const Text('Porcentaje bajo umbral'),
                        subtitle: Text(
                          'Repuestos bajo umbral: ${state.belowThreshold!.sparesBelowThreshold}/${state.belowThreshold!.sparesWithThreshold}',
                        ),
                        trailing: Text(
                          '${state.belowThreshold!.belowThresholdPercent.toStringAsFixed(2)}%',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    'Top vendidos',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...state.topSelling.map(
                    (m) => Card(
                      child: ListTile(
                        title: Text(m.spareName),
                        subtitle: Text('SAV: ${m.savCode}'),
                        trailing: Text('${m.unitsSold} u'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Repuestos estancados',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...state.stagnant.map(
                    (m) => Card(
                      child: ListTile(
                        title: Text(m.spareName),
                        subtitle: Text(
                          'SAV: ${m.savCode} | Stock: ${m.currentStock}',
                        ),
                        trailing: Text(
                          m.neverSold || m.daysWithoutSales == null
                              ? 'Nunca vendido'
                              : '${m.daysWithoutSales} días',
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
