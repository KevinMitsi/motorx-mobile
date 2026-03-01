import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/app_error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/admin_entities.dart';
import '../providers/admin_provider.dart';

/// Admin user management screen.
class AdminUsersScreen extends ConsumerWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(adminUserNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.users),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(adminUserNotifierProvider.notifier).refresh(),
        child: usersState.when(
          data: (users) {
            if (users.isEmpty) {
              return const Center(child: Text('No hay usuarios'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final roleLabel =
                    AppStrings.roleLabels[user.role] ?? user.role;

                Color statusColor;
                String statusText;
                if (user.isDeleted) {
                  statusColor = Colors.grey;
                  statusText = 'Eliminado';
                } else if (user.accountLocked) {
                  statusColor = colorScheme.error;
                  statusText = 'Bloqueado';
                } else if (user.enabled) {
                  statusColor = Colors.green;
                  statusText = 'Activo';
                } else {
                  statusColor = Colors.orange;
                  statusText = 'Inactivo';
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          statusColor.withValues(alpha: 0.15),
                      child: Icon(Icons.person_rounded,
                          color: statusColor),
                    ),
                    title: Text(
                      user.name,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        decoration: user.isDeleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(
                        '$roleLabel · $statusText\n${user.email}'),
                    isThreeLine: true,
                    trailing: PopupMenuButton<String>(
                      onSelected: (action) =>
                          _handleAction(context, ref, action, user),
                      itemBuilder: (ctx) => [
                        if (!user.isDeleted && !user.accountLocked)
                          const PopupMenuItem(
                            value: 'block',
                            child: Text(AppStrings.blockUser),
                          ),
                        if (!user.isDeleted && user.accountLocked)
                          const PopupMenuItem(
                            value: 'unblock',
                            child: Text(AppStrings.unblockUser),
                          ),
                        if (!user.isDeleted)
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              AppStrings.deleteUser,
                              style:
                                  TextStyle(color: colorScheme.error),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () =>
              const LoadingWidget(message: 'Cargando usuarios...'),
          error: (e, _) => AppErrorWidget(
            message: e.toString(),
            onRetry: () =>
                ref.read(adminUserNotifierProvider.notifier).refresh(),
          ),
        ),
      ),
    );
  }

  void _handleAction(
    BuildContext context,
    WidgetRef ref,
    String action,
    AdminUserEntity user,
  ) {
    switch (action) {
      case 'block':
        _confirmAction(
          context,
          ref,
          title: AppStrings.blockUser,
          message:
              '¿Bloquear a ${user.name}? No podrá iniciar sesión.',
          onConfirm: () => ref
              .read(adminUserNotifierProvider.notifier)
              .blockUser(user.id),
          successMessage: 'Usuario bloqueado',
        );
        break;
      case 'unblock':
        _confirmAction(
          context,
          ref,
          title: AppStrings.unblockUser,
          message: '¿Desbloquear a ${user.name}?',
          onConfirm: () => ref
              .read(adminUserNotifierProvider.notifier)
              .unblockUser(user.id),
          successMessage: 'Usuario desbloqueado',
        );
        break;
      case 'delete':
        _confirmAction(
          context,
          ref,
          title: AppStrings.deleteUser,
          message:
              '¿Eliminar a ${user.name}? Se desactivará y bloqueará su cuenta.',
          onConfirm: () => ref
              .read(adminUserNotifierProvider.notifier)
              .deleteUser(user.id),
          successMessage: 'Usuario eliminado',
        );
        break;
    }
  }

  void _confirmAction(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String message,
    required Future<void> Function() onConfirm,
    required String successMessage,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await onConfirm();
                if (context.mounted) {
                  context.showSnackBar(successMessage);
                }
              } catch (e) {
                if (context.mounted) {
                  context.showSnackBar(e.toString(), isError: true);
                }
              }
            },
            child: Text(AppStrings.confirm),
          ),
        ],
      ),
    );
  }
}
