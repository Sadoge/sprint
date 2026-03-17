import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/domain/models/timer_state.dart';

void main() {
  group('TimerState.progress', () {
    test('returns 0 when total duration is zero', () {
      const state = TimerState(
        timeRemaining: Duration.zero,
        totalDuration: Duration.zero,
      );

      expect(state.progress, 0);
    });

    test('returns 0 when no time has elapsed', () {
      const state = TimerState(
        timeRemaining: Duration(minutes: 15),
        totalDuration: Duration(minutes: 15),
      );

      expect(state.progress, 0);
    });

    test('returns 1 when timer is complete', () {
      const state = TimerState(
        timeRemaining: Duration.zero,
        totalDuration: Duration(minutes: 15),
      );

      expect(state.progress, 1);
    });

    test('returns fractional progress for partial completion', () {
      const state = TimerState(
        timeRemaining: Duration(minutes: 9),
        totalDuration: Duration(minutes: 15),
      );

      expect(state.progress, closeTo(0.4, 0.0001));
    });
  });
}
