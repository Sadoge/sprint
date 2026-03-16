import 'package:freezed_annotation/freezed_annotation.dart';
import 'timer_status.dart';

part 'timer_state.freezed.dart';

@freezed
abstract class TimerState with _$TimerState {
  const TimerState._();

  const factory TimerState({
    @Default(TimerStatus.idle) TimerStatus status,
    required Duration timeRemaining,
    required Duration totalDuration,
    @Default(0) int todayCount,
    @Default(0) int streak,
  }) = _TimerState;

  double get progress {
    if (totalDuration.inSeconds == 0) return 0;
    return 1 - (timeRemaining.inSeconds / totalDuration.inSeconds);
  }
}
