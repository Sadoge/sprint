import 'package:flutter/material.dart';
import '../tokens.dart';
import '../typography.dart';

class SettingRow extends StatelessWidget {
  final String label;
  final String? description;
  final Widget trailing;

  const SettingRow({
    super.key,
    required this.label,
    this.description,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTypography.settingTitle),
                if (description != null) ...[
                  const SizedBox(height: 4),
                  Text(description!, style: AppTypography.mono),
                ],
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
