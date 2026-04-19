import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../data/models/spare_model.dart';
import '../providers/spare_provider.dart';
import 'spare_form_screen.dart';

class SparesScreen extends ConsumerStatefulWidget {
  final bool belowThresholdOnly;

  const SparesScreen({super.key, this.belowThresholdOnly = false});

  @override
  ConsumerState<SparesScreen> createState() => _SparesScreenState();
}

class _SparesScreenState extends ConsumerState<SparesScreen> {
  final _nameController = TextEditingController();
  final _savCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(spareNotifierProvider.notifier)
          .load(belowThresholdOnly: widget.belowThresholdOnly);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _savCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(spareNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.belowThresholdOnly ? 'Repuestos bajo umbral' : 'Repuestos',
        ),
      ),
      floatingActionButton: widget.belowThresholdOnly
          ? null
          : FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SpareFormScreen()),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Nuevo'),
            ),
      body: Column(
        children: [
          if (!widget.belowThresholdOnly)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _savCodeController,
                      decoration: const InputDecoration(labelText: 'SAV'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref
                          .read(spareNotifierProvider.notifier)
                          .setFilter(
                            name: _nameController.text,
                            savCode: _savCodeController.text,
                          );
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref
                  .read(spareNotifierProvider.notifier)
                  .load(belowThresholdOnly: widget.belowThresholdOnly),
              child: state.when(
                data: (spares) {
                  if (spares.isEmpty) {
                    return const Center(
                      child: Text('No hay repuestos para mostrar'),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: spares.length,
                    itemBuilder: (context, index) {
                      final spare = spares[index];
                      return _SpareCard(
                        spare: spare,
                        onEdit: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SpareFormScreen(spare: spare),
                          ),
                        ),
                        onDelete: widget.belowThresholdOnly
                            ? null
                            : () => _deleteSpare(spare.id),
                        onUpdatePrice: () => _updatePrice(spare),
                        onNotify: () => _notifyRestock(spare.id),
                      );
                    },
                  );
                },
                loading: () =>
                    const LoadingWidget(message: 'Cargando repuestos...'),
                error: (e, _) => AppErrorWidget(
                  message: e.toString(),
                  onRetry: () => ref
                      .read(spareNotifierProvider.notifier)
                      .load(belowThresholdOnly: widget.belowThresholdOnly),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteSpare(int id) async {
    try {
      await ref.read(spareNotifierProvider.notifier).deleteSpare(id);
      if (mounted) context.showSnackBar('Repuesto eliminado');
    } catch (e) {
      if (mounted) context.showSnackBar(e.toString(), isError: true);
    }
  }

  Future<void> _notifyRestock(int id) async {
    try {
      final message = await ref
          .read(spareNotifierProvider.notifier)
          .notifyRestock(id);
      if (mounted) context.showSnackBar(message);
    } catch (e) {
      if (mounted) context.showSnackBar(e.toString(), isError: true);
    }
  }

  Future<void> _updatePrice(SpareModel spare) async {
    final controller = TextEditingController(
      text: spare.purchasePriceWithVat.toStringAsFixed(0),
    );
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Actualizar precio de compra'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Precio compra con IVA'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final value = double.tryParse(controller.text.trim());
              if (value == null) return;
              try {
                await ref
                    .read(spareNotifierProvider.notifier)
                    .updatePurchasePrice(
                      id: spare.id,
                      purchasePriceWithVat: value,
                    );
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Precio actualizado')),
                );
              } catch (e) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(
                    ctx,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}

class _SpareCard extends StatelessWidget {
  final SpareModel spare;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;
  final VoidCallback onUpdatePrice;
  final VoidCallback onNotify;

  const _SpareCard({
    required this.spare,
    required this.onEdit,
    this.onDelete,
    required this.onUpdatePrice,
    required this.onNotify,
  });

  @override
  Widget build(BuildContext context) {
    final isCritical =
        spare.stockThreshold > 0 && spare.quantity < spare.stockThreshold;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(spare.name),
        subtitle: Text(
          'SAV: ${spare.savCode} | Stock: ${spare.quantity} | Venta: ${spare.salePrice.toStringAsFixed(0)}',
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') onEdit();
            if (value == 'update_price') onUpdatePrice();
            if (value == 'delete' && onDelete != null) onDelete!.call();
            if (value == 'notify') onNotify();
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Editar')),
            const PopupMenuItem(
              value: 'update_price',
              child: Text('Actualizar precio compra'),
            ),
            if (onDelete != null)
              const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
            const PopupMenuItem(
              value: 'notify',
              child: Text('Notificar surtido'),
            ),
          ],
        ),
        leading: CircleAvatar(
          backgroundColor: isCritical
              ? Theme.of(context).colorScheme.errorContainer
              : Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            spare.isOil ? Icons.opacity_rounded : Icons.build_rounded,
            color: isCritical
                ? Theme.of(context).colorScheme.onErrorContainer
                : Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
