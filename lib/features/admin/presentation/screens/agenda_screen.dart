import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../appointments/presentation/widgets/appointment_card.dart';
import '../providers/admin_provider.dart';

/// Admin agenda screen — shows all appointments for a selected date.
class AgendaScreen extends ConsumerStatefulWidget {
  const AgendaScreen({super.key});

  @override
  ConsumerState<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends ConsumerState<AgendaScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(adminAgendaNotifierProvider.notifier)
          .fetchAgenda(_selectedDate.toApiDate());
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
      ref
          .read(adminAgendaNotifierProvider.notifier)
          .fetchAgenda(picked.toApiDate());
    }
  }

  @override
  Widget build(BuildContext context) {
    final agendaState = ref.watch(adminAgendaNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.agenda),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_rounded),
            onPressed: _pickDate,
            tooltip: 'Seleccionar fecha',
          ),
        ],
      ),
      body: Column(
        children: [
          // Date display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            child: Row(
              children: [
                Icon(Icons.today_rounded,
                    size: 20, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  _selectedDate.toReadableDate(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(
                        () => _selectedDate = DateTime.now());
                    ref
                        .read(adminAgendaNotifierProvider.notifier)
                        .fetchAgenda(DateTime.now().toApiDate());
                  },
                  child: const Text('Hoy'),
                ),
              ],
            ),
          ),
          // List
          Expanded(
            child: agendaState.when(
              data: (appointments) {
                if (appointments.isEmpty) {
                  return const Center(
                    child: Text('No hay citas para esta fecha'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    return AppointmentCard(
                      appointment: appointments[index],
                      onTap: () => context.push(
                          '/admin/appointments/${appointments[index].id}'),
                    );
                  },
                );
              },
              loading: () => const LoadingWidget(message: 'Cargando agenda...'),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
