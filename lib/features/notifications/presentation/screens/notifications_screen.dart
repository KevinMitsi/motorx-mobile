import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../providers/notification_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        actions: [
          IconButton(
            tooltip: 'Crear notificación (admin)',
            icon: const Icon(Icons.add_alert_rounded),
            onPressed: () => _showCreateNotificationDialog(context, ref),
          ),
          IconButton(
            tooltip: 'Marcar todas como leídas',
            icon: const Icon(Icons.done_all_rounded),
            onPressed: () async {
              try {
                final message = await ref
                    .read(notificationNotifierProvider.notifier)
                    .markAllRead();
                if (context.mounted) {
                  context.showSnackBar(message);
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
      body: RefreshIndicator(
        onRefresh: () => ref.read(notificationNotifierProvider.notifier).load(),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Solo no leídas'),
              value: state.onlyUnread,
              onChanged: (v) => ref
                  .read(notificationNotifierProvider.notifier)
                  .load(onlyUnread: v),
            ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.notifications.isEmpty
                  ? const Center(child: Text('No hay notificaciones'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        final n = state.notifications[index];
                        final urgencyLabel =
                            AppStrings.notificationUrgencyLabels[n.urgency] ??
                            n.urgency;
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(urgencyLabel.characters.first),
                            ),
                            title: Text(n.title),
                            subtitle: Text(
                              '${n.description}\nUrgencia: $urgencyLabel',
                            ),
                            isThreeLine: true,
                            trailing: n.isRead
                                ? const Icon(Icons.mark_email_read_rounded)
                                : IconButton(
                                    icon: const Icon(
                                      Icons.mark_email_read_outlined,
                                    ),
                                    onPressed: () async {
                                      try {
                                        await ref
                                            .read(
                                              notificationNotifierProvider
                                                  .notifier,
                                            )
                                            .markRead(n.id);
                                      } catch (e) {
                                        if (context.mounted) {
                                          context.showSnackBar(
                                            e.toString(),
                                            isError: true,
                                          );
                                        }
                                      }
                                    },
                                  ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCreateNotificationDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final userIdCtrl = TextEditingController();
    final titleCtrl = TextEditingController();
    final descriptionCtrl = TextEditingController();
    final sourceCtrl = TextEditingController();
    String urgency = 'MEDIUM';

    await showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: const Text('Crear notificación (admin)'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: userIdCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'User ID destino',
                      ),
                    ),
                    TextField(
                      controller: titleCtrl,
                      decoration: const InputDecoration(labelText: 'Título'),
                    ),
                    TextField(
                      controller: descriptionCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                      ),
                      maxLines: 2,
                    ),
                    TextField(
                      controller: sourceCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Fuente (opcional)',
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: urgency,
                      items: const [
                        DropdownMenuItem(value: 'LOW', child: Text('Baja')),
                        DropdownMenuItem(value: 'MEDIUM', child: Text('Media')),
                        DropdownMenuItem(value: 'HIGH', child: Text('Alta')),
                        DropdownMenuItem(
                          value: 'CRITICAL',
                          child: Text('Crítica'),
                        ),
                      ],
                      onChanged: (v) => setState(() => urgency = v ?? 'MEDIUM'),
                      decoration: const InputDecoration(labelText: 'Urgencia'),
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
                  label: 'Enviar',
                  onPressed: () async {
                    try {
                      await ref
                          .read(notificationNotifierProvider.notifier)
                          .createNotification(
                            userId: int.tryParse(userIdCtrl.text.trim()) ?? 0,
                            title: titleCtrl.text.trim(),
                            description: descriptionCtrl.text.trim(),
                            urgency: urgency,
                            source: sourceCtrl.text.trim().isEmpty
                                ? null
                                : sourceCtrl.text.trim(),
                          );
                      if (!context.mounted) return;
                      Navigator.pop(ctx);
                      context.showSnackBar('Notificación creada');
                    } catch (e) {
                      if (context.mounted) {
                        context.showSnackBar(e.toString(), isError: true);
                      }
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
