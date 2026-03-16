import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/utils/streak_calculator.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/sprint_repository_impl.dart';
import '../../domain/models/timer_state.dart';
import '../../domain/models/timer_status.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/sprint_repository.dart';
import '../history/history_viewmodel.dart';

part 'timer_viewmodel.g.dart';

@riverpod
AppDatabase database(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

@riverpod
SprintRepository sprintRepository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return SprintRepositoryImpl(db.sprintDao);
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return SettingsRepositoryImpl(db.settingsDao);
}

@riverpod
class TimerViewModel extends _$TimerViewModel {
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<TimerState> build() async {
    ref.onDispose(() {
      _timer?.cancel();
      _audioPlayer.dispose();
    });

    final settingsRepo = ref.watch(settingsRepositoryProvider);
    final sprintRepo = ref.watch(sprintRepositoryProvider);

    final settings = await settingsRepo.getSettings();
    final heatmap = await sprintRepo.getLast30Days();
    final streak = calculateStreak(heatmap);

    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);
    final todayCount = heatmap[todayKey] ?? 0;

    final duration = Duration(minutes: settings.sprintDuration);

    return TimerState(
      timeRemaining: duration,
      totalDuration: duration,
      todayCount: todayCount,
      streak: streak,
    );
  }

  void start() {
    final current = state.valueOrNull;
    if (current == null || current.status == TimerStatus.running) return;

    state = AsyncData(current.copyWith(status: TimerStatus.running));

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final s = state.valueOrNull;
      if (s == null) return;

      final remaining = s.timeRemaining - const Duration(seconds: 1);
      if (remaining.inSeconds <= 0) {
        _onComplete();
      } else {
        state = AsyncData(s.copyWith(timeRemaining: remaining));
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;

    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncData(
      current.copyWith(
        status: TimerStatus.idle,
        timeRemaining: current.totalDuration,
      ),
    );
  }

  Future<void> _onComplete() async {
    _timer?.cancel();
    _timer = null;

    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncData(
      current.copyWith(
        status: TimerStatus.completed,
        timeRemaining: Duration.zero,
      ),
    );

    final sprintRepo = ref.read(sprintRepositoryProvider);
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final settings = await settingsRepo.getSettings();

    await sprintRepo.recordSprint(current.totalDuration.inMinutes);

    // Recalculate
    final heatmap = await sprintRepo.getLast30Days();
    final streak = calculateStreak(heatmap);
    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);
    final todayCount = heatmap[todayKey] ?? 0;

    state = AsyncData(
      current.copyWith(
        status: TimerStatus.completed,
        timeRemaining: Duration.zero,
        todayCount: todayCount,
        streak: streak,
      ),
    );

    // Play sound
    if (settings.soundEnabled) {
      try {
        await _audioPlayer.play(AssetSource('sounds/complete.mp3'));
      } catch (_) {}
    }

    // Invalidate history
    ref.invalidate(historyViewModelProvider);

    // Reset after delay
    await Future.delayed(const Duration(seconds: 2));
    final afterComplete = state.valueOrNull;
    if (afterComplete?.status == TimerStatus.completed) {
      state = AsyncData(
        afterComplete!.copyWith(
          status: TimerStatus.idle,
          timeRemaining: afterComplete.totalDuration,
        ),
      );
    }
  }
}
