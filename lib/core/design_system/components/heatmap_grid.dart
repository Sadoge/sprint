import 'package:flutter/material.dart';
import '../tokens.dart';
import '../typography.dart';

class HeatmapGrid extends StatelessWidget {
  final Map<DateTime, int> data;

  const HeatmapGrid({super.key, required this.data});

  Color _colorForCount(int count) {
    return switch (count) {
      0 => AppColors.heatmap0,
      1 => AppColors.heatmap1,
      2 => AppColors.heatmap2,
      _ => AppColors.heatmap3,
    };
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);

    // Generate 30 days from 29 days ago to today
    final days = List.generate(30, (i) {
      final date = todayKey.subtract(Duration(days: 29 - i));
      return date;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Grid
        _buildGrid(days, todayKey),
        const SizedBox(height: 16),
        // Legend
        _buildLegend(),
      ],
    );
  }

  Widget _buildGrid(List<DateTime> days, DateTime todayKey) {
    final rows = <Widget>[];
    for (var row = 0; row < 3; row++) {
      final cells = <Widget>[];
      for (var col = 0; col < 10; col++) {
        final index = row * 10 + col;
        if (index >= days.length) {
          cells.add(const SizedBox(width: 26, height: 26));
          continue;
        }
        final date = days[index];
        final count = data[date] ?? 0;
        final isToday = date == todayKey;

        cells.add(
          Tooltip(
            message: '${date.month}/${date.day}: $count sprints',
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: _colorForCount(count),
                borderRadius: BorderRadius.circular(3),
                border: isToday
                    ? Border.all(color: AppColors.accent, width: 1.5)
                    : null,
              ),
            ),
          ),
        );
      }
      rows.add(
        Row(
          children: cells.expand((w) => [w, const SizedBox(width: 6)]).toList()
            ..removeLast(),
        ),
      );
    }
    return Column(
      children: rows.expand((w) => [w, const SizedBox(height: 6)]).toList()
        ..removeLast(),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: [
        _legendItem('0', AppColors.heatmap0),
        const SizedBox(width: 16),
        _legendItem('1', AppColors.heatmap1),
        const SizedBox(width: 16),
        _legendItem('2', AppColors.heatmap2),
        const SizedBox(width: 16),
        _legendItem('3+', AppColors.heatmap3),
      ],
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.mono.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
