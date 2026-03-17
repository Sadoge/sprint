import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../tokens.dart';
import '../typography.dart';

class AppTabBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppTabBar({super.key, required this.currentIndex, required this.onTap});

  static const _tabs = [
    (icon: LucideIcons.timer, label: 'TIMER'),
    (icon: LucideIcons.square, label: 'HISTORY'),
    (icon: LucideIcons.settings, label: 'SETTINGS'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(21, 12, 21, 21),
        child: Container(
          height: 62,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Row(
            children: List.generate(_tabs.length, (index) {
              final tab = _tabs[index];
              final isActive = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: AppDurations.fast,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.accentSubtle
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          tab.icon,
                          size: 18,
                          color: isActive
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tab.label,
                          style: isActive
                              ? AppTypography.labelTiny
                              : AppTypography.labelTinyInactive,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
