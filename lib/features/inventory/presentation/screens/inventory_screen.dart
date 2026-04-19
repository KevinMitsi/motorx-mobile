import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/app_button.dart';
import '../providers/inventory_provider.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventoryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transacciones de inventario'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Compras'),
            Tab(text: 'Ventas'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_tabController.index == 0) {
            _showPurchaseDialog();
          } else {
            _showSaleDialog();
          }
        },
        icon: const Icon(Icons.add),
        label: Text(
          _tabController.index == 0 ? 'Registrar compra' : 'Registrar venta',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(inventoryNotifierProvider.notifier).loadAll(),
        child: Column(
          children: [
            if (state.todaySummary != null)
              Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  leading: const Icon(Icons.today_rounded),
                  title: Text(
                    'Ventas del día: ${state.todaySummary!.totalTransactions}',
                  ),
                  subtitle: Text(
                    'Monto total: ${state.todaySummary!.totalAmount.toStringAsFixed(0)}',
                  ),
                ),
              ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      controller: _tabController,
                      children: [_PurchaseList(), _SaleList()],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPurchaseDialog() async {
    final spareIdCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    final unitCostCtrl = TextEditingController();
    final supplierCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Registrar compra'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: spareIdCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ID repuesto'),
              ),
              TextField(
                controller: qtyCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Cantidad'),
              ),
              TextField(
                controller: unitCostCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Costo unitario'),
              ),
              TextField(
                controller: supplierCtrl,
                decoration: const InputDecoration(
                  labelText: 'Proveedor (opcional)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          AppButton(
            width: 120,
            label: 'Guardar',
            onPressed: () async {
              try {
                await ref
                    .read(inventoryNotifierProvider.notifier)
                    .createPurchase(
                      supplier: supplierCtrl.text.trim().isEmpty
                          ? null
                          : supplierCtrl.text.trim(),
                      items: [
                        {
                          'spareId': int.tryParse(spareIdCtrl.text.trim()) ?? 0,
                          'quantity': int.tryParse(qtyCtrl.text.trim()) ?? 0,
                          'unitCost':
                              double.tryParse(unitCostCtrl.text.trim()) ?? 0,
                        },
                      ],
                    );
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Compra registrada')),
                );
              } catch (e) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(
                    ctx,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showSaleDialog() async {
    final spareIdCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    final appointmentCtrl = TextEditingController();
    final notesCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Registrar venta'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: spareIdCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ID repuesto'),
              ),
              TextField(
                controller: qtyCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Cantidad'),
              ),
              TextField(
                controller: appointmentCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID cita (opcional, debe estar IN_PROGRESS)',
                ),
              ),
              TextField(
                controller: notesCtrl,
                decoration: const InputDecoration(
                  labelText: 'Notas (opcional)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          AppButton(
            width: 120,
            label: 'Guardar',
            onPressed: () async {
              try {
                await ref
                    .read(inventoryNotifierProvider.notifier)
                    .createSale(
                      appointmentId: int.tryParse(appointmentCtrl.text.trim()),
                      notes: notesCtrl.text.trim().isEmpty
                          ? null
                          : notesCtrl.text.trim(),
                      items: [
                        {
                          'spareId': int.tryParse(spareIdCtrl.text.trim()) ?? 0,
                          'quantity': int.tryParse(qtyCtrl.text.trim()) ?? 0,
                        },
                      ],
                    );
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Venta registrada')),
                );
              } catch (e) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(
                    ctx,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class _PurchaseList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchases = ref.watch(inventoryNotifierProvider).purchases;
    if (purchases.isEmpty) {
      return const Center(child: Text('Sin compras registradas'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: purchases.length,
      itemBuilder: (context, index) {
        final p = purchases[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ExpansionTile(
            title: Text('Compra #${p.id}'),
            subtitle: Text('Total: ${p.total.toStringAsFixed(0)}'),
            children: p.items
                .map(
                  (i) => ListTile(
                    dense: true,
                    title: Text(i.spareName),
                    subtitle: Text('Cantidad: ${i.quantity}'),
                    trailing: Text(i.unitCost.toStringAsFixed(0)),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _SaleList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sales = ref.watch(inventoryNotifierProvider).sales;
    if (sales.isEmpty) {
      return const Center(child: Text('Sin ventas registradas'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: sales.length,
      itemBuilder: (context, index) {
        final s = sales[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ExpansionTile(
            title: Text('Venta #${s.id}'),
            subtitle: Text('Total: ${s.total.toStringAsFixed(0)}'),
            children: s.items
                .map(
                  (i) => ListTile(
                    dense: true,
                    title: Text(i.spareName),
                    subtitle: Text('Cantidad: ${i.quantity}'),
                    trailing: Text(i.unitPrice.toStringAsFixed(0)),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
