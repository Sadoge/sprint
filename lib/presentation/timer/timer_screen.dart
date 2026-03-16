import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/design_system/tokens.dart';
import '../../core/design_system/typography.dart';
import '../../core/design_system/components/sprint_ring.dart';
import '../../core/design_system/components/circle_button.dart';
import '../../core/design_system/components/streak_display.dart';
import '../../domain/models/timer_status.dart';
import 'timer_viewmodel.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerAsync = ref.watch(timerViewModelProvider);

    return timerAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (timer) => SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 12, 28, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SPRINT', style: AppTypography.brand),
                      const SizedBox(height: 2),
                      Text('focus timer', style: AppTypography.brandSubtitle),
                    ],
                  ),
                  Text(
                    '${timer.todayCount} sprints',
                    style: AppTypography.sprintCount.copyWith(
                      color: timer.todayCount > 0
                          ? AppColors.accent
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Timer area
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ring with glow
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Ambient glow when running
                      AnimatedContainer(
                        duration: AppDurations.slow,
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: timer.status == TimerStatus.running
                              ? [
                                  BoxShadow(
                                    color: AppColors.accent.withValues(alpha: 0.12),
                                    blurRadius: 80,
                                    spreadRadius: 20,
                                  ),
                                ]
                              : [],
                        ),
                      ),
                      // Ring
                      SprintRing(
                        progress: timer.progress,
                        size: 220,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (timer.status == TimerStatus.completed)
                              _CompletedCheckmark()
                            else
                              Text(
                                _formatTime(timer.timeRemaining),
                                style: AppTypography.countdown,
                              ),
                            const SizedBox(height: 6),
                            Text(
                              '${timer.totalDuration.inMinutes} min sprint',
                              style: AppTypography.mono,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Play/Stop button
                  CircleButton(
                    onTap: () {
                      final vm = ref.read(timerViewModelProvider.notifier);
                      if (timer.status == TimerStatus.running) {
                        vm.stop();
                      } else {
                        vm.start();
                      }
                    },
                    backgroundColor: timer.status == TimerStatus.running
                        ? AppColors.surface
                        : AppColors.accent,
                    child: Icon(
                      timer.status == TimerStatus.running
                          ? LucideIcons.x
                          : LucideIcons.play,
                      size: 28,
                      color: timer.status == TimerStatus.running
                          ? AppColors.textPrimary
                          : AppColors.background,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Streak
                  StreakDisplay(streak: timer.streak),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompletedCheckmark extends StatefulWidget {
  @override
  State<_CompletedCheckmark> createState() => _CompletedCheckmarkState();
}

class _CompletedCheckmarkState extends State<_CompletedCheckmark>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppDurations.normal,
      vsync: this,
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: const Icon(
        LucideIcons.check,
        size: 48,
        color: AppColors.accent,
      ),
    );
  }
}
