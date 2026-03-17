import 'package:flutter/material.dart';
import '../tokens.dart';
import '../typography.dart';

class DurationPillSelector extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const DurationPillSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _options = [10, 15, 25];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _options.map((minutes) {
        final isActive = minutes == selected;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: minutes == _options.last ? 0 : 10),
            child: GestureDetector(
              onTap: () => onChanged(minutes),
              child: AnimatedContainer(
                duration: AppDurations.fast,
                height: 44,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.accentSubtle
                      : AppColors.surfaceHigh,
                  borderRadius: BorderRadius.circular(22),
                  border: isActive
                      ? Border.all(color: AppColors.accent, width: 1.5)
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${minutes}m',
                  style: isActive
                      ? AppTypography.pillTextActive
                      : AppTypography.pillText,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
