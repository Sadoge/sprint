import 'package:flutter/material.dart';
import '../tokens.dart';
import '../typography.dart';

class StreakDisplay extends StatelessWidget {
  final int streak;

  const StreakDisplay({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$streak',
          style: AppTypography.displayLarge.copyWith(
            color: streak > 0 ? AppColors.textPrimary : AppColors.surfaceHigh,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('day streak', style: AppTypography.mono),
            if (streak >= 3) ...[
              const SizedBox(width: 6),
              Text(
                '🔥',
                style: AppTypography.mono.copyWith(fontSize: 14),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
