import 'package:flutter/material.dart';
import '../tokens.dart';
import '../typography.dart';

class StatRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showBorder;

  const StatRow({
    super.key,
    required this.label,
    required this.value,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: showBorder
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.border, width: 1),
              ),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.monoMedium),
          Text(value, style: AppTypography.statValue),
        ],
      ),
    );
  }
}
