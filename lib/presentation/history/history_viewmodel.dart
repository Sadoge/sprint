import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/utils/streak_calculator.dart';
import '../timer/timer_viewmodel.dart';

part 'history_viewmodel.freezed.dart';
part 'history_viewmodel.g.dart';

@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState({
    required Map<DateTime, int> heatmapData,
    required int streak,
    required int todayCount,
    required int totalSprints,
    required int activeDays,
  }) = _HistoryState;
}

@riverpod
class HistoryViewModel extends _$HistoryViewModel {
  @override
  Future<HistoryState> build() async {
    final sprintRepo = ref.watch(sprintRepositoryProvider);

    final heatmap = await sprintRepo.getLast30Days();
    final streak = calculateStreak(heatmap);
    final totalSprints = await sprintRepo.getTotalSprints();
    final activeDays = await sprintRepo.getActiveDays();

    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);
    final todayCount = heatmap[todayKey] ?? 0;

    return HistoryState(
      heatmapData: heatmap,
      streak: streak,
      todayCount: todayCount,
      totalSprints: totalSprints,
      activeDays: activeDays,
    );
  }
}
