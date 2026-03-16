import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/design_system/tokens.dart';
import '../../core/design_system/typography.dart';
import '../../core/design_system/components/duration_pill_selector.dart';
import '../../core/design_system/components/setting_row.dart';
import 'settings_viewmodel.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsViewModelProvider);

    return settingsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (settings) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Settings', style: AppTypography.screenTitle),
              const SizedBox(height: 32),

              // Duration section
              Text('DURATION', style: AppTypography.labelSmall),
              const SizedBox(height: 12),
              DurationPillSelector(
                selected: settings.sprintDuration,
                onChanged: (minutes) {
                  ref.read(settingsViewModelProvider.notifier).setDuration(minutes);
                },
              ),
              const SizedBox(height: 32),

              // Sound section
              Text('SOUND', style: AppTypography.labelSmall),
              const SizedBox(height: 12),
              SettingRow(
                label: 'Completion sound',
                description: 'Play a chime when timer ends',
                trailing: CupertinoSwitch(
                  value: settings.soundEnabled,
                  activeTrackColor: AppColors.accent,
                  onChanged: (_) {
                    ref.read(settingsViewModelProvider.notifier).toggleSound();
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Danger zone
              Text(
                'DANGER ZONE',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.destructive,
                ),
              ),
              const SizedBox(height: 12),
              SettingRow(
                label: 'Reset all data',
                description: 'Clear streak and history',
                trailing: GestureDetector(
                  onTap: () => _showResetDialog(context, ref),
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.destructive,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text('Reset', style: AppTypography.resetButton),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Reset all data?',
          style: AppTypography.settingTitle,
        ),
        content: Text(
          'This will permanently clear your streak and sprint history.',
          style: AppTypography.mono,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTypography.mono.copyWith(color: AppColors.textPrimary),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(settingsViewModelProvider.notifier).resetAllData();
              Navigator.pop(context);
            },
            child: Text(
              'Reset',
              style: AppTypography.resetButton,
            ),
          ),
        ],
      ),
    );
  }
}
