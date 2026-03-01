import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../appointments/domain/entities/appointment_entity.dart';
import '../../../appointments/presentation/widgets/appointment_card.dart';
import '../providers/admin_provider.dart';

/// Calendar view — shows appointments within a date range.
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _start;
  late DateTime _end;
  DateTime _focusedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _start = DateTime(now.year, now.month, 1);
    _end = DateTime(now.year, now.month + 1, 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMonth();
    });
  }

  void _loadMonth() {
    ref.read(adminCalendarNotifierProvider.notifier).fetchCalendar(
          _start.toApiDate(),
          _end.toApiDate(),
        );
  }

  void _changeMonth(int delta) {
    setState(() {
      _focusedDate =
          DateTime(_focusedDate.year, _focusedDate.month + delta, 1);
      _start = DateTime(_focusedDate.year, _focusedDate.month, 1);
      _end = DateTime(_focusedDate.year, _focusedDate.month + 1, 0);
    });
    _loadMonth();
  }

  @override
  Widget build(BuildContext context) {
    final calendarState = ref.watch(adminCalendarNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.calendar),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
          tooltip: 'Volver',
        ),
      ),
      body: Column(
        children: [
          // Month nav
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded),
                  onPressed: () => _changeMonth(-1),
                ),
                Text(
                  '${months[_focusedDate.month - 1]} ${_focusedDate.year}',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right_rounded),
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
          ),

          Expanded(
            child: calendarState.when(
              data: (appointments) {
                if (appointments.isEmpty) {
                  return const Center(
                    child: Text('No hay citas en este período'),
                  );
                }

                // Group by date
                final grouped = <String, List<AppointmentEntity>>{};
                for (final a in appointments) {
                  grouped.putIfAbsent(a.appointmentDate, () => []).add(a);
                }
                final sortedDates = grouped.keys.toList()..sort();

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sortedDates.length,
                  itemBuilder: (context, index) {
                    final date = sortedDates[index];
                    final dayAppointments = grouped[date]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: colorScheme.primaryContainer,
                                  borderRadius:
                                      BorderRadius.circular(8),
                                ),
                                child: Text(
                                  date,
                                  style: textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme
                                        .onPrimaryContainer,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${dayAppointments.length} cita(s)',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...dayAppointments.map(
                          (a) => AppointmentCard(
                            appointment: a,
                            onTap: () => context.push(
                                '/admin/appointments/${a.id}'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              loading: () =>
                  const LoadingWidget(message: 'Cargando calendario...'),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
