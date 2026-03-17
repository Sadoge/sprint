import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/design_system/tokens.dart';
import '../../core/design_system/typography.dart';
import '../../core/design_system/components/heatmap_grid.dart';
import '../../core/design_system/components/stat_row.dart';
import 'history_viewmodel.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyViewModelProvider);

    return historyAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (history) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Last 30 days', style: AppTypography.screenTitle),
              const SizedBox(height: 28),

              HeatmapGrid(data: history.heatmapData),
              const SizedBox(height: 28),

              StatRow(label: 'Current streak', value: '${history.streak} days'),
              StatRow(label: 'Sprints today', value: '${history.todayCount}'),
              StatRow(label: 'Total sprints', value: '${history.totalSprints}'),
              StatRow(
                label: 'Active days',
                value: '${history.activeDays}',
                showBorder: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
