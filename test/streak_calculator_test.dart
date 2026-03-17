import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/utils/streak_calculator.dart';

void main() {
  group('calculateStreak', () {
    DateTime today() {
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day);
    }

    test('returns 0 for empty history', () {
      expect(calculateStreak({}, now: DateTime(2026, 3, 17)), 0);
    });

    test('returns 1 for single day (today)', () {
      final history = {today(): 2};
      expect(calculateStreak(history, now: today()), 1);
    });

    test('returns correct multi-day streak', () {
      final t = today();
      final history = {
        t: 1,
        t.subtract(const Duration(days: 1)): 3,
        t.subtract(const Duration(days: 2)): 1,
        t.subtract(const Duration(days: 3)): 2,
      };
      expect(calculateStreak(history, now: t), 4);
    });

    test('stops at broken streak', () {
      final t = today();
      final history = {
        t: 1,
        t.subtract(const Duration(days: 1)): 1,
        // day 2 missing
        t.subtract(const Duration(days: 3)): 5,
      };
      expect(calculateStreak(history, now: t), 2);
    });

    test('returns 0 if streak broken yesterday (no today entry)', () {
      final t = today();
      final history = {
        t.subtract(const Duration(days: 1)): 1,
        t.subtract(const Duration(days: 2)): 1,
      };
      // Today has no entry, so streak is 0
      expect(calculateStreak(history, now: t), 0);
    });

    test('ignores entries with count of 0', () {
      final t = today();
      final history = {t: 0, t.subtract(const Duration(days: 1)): 2};
      expect(calculateStreak(history, now: t), 0);
    });

    test('handles month and year boundaries', () {
      final history = {
        DateTime(2026, 1, 1): 1,
        DateTime(2025, 12, 31): 1,
        DateTime(2025, 12, 30): 1,
      };

      expect(calculateStreak(history, now: DateTime(2026, 1, 1)), 3);
    });

    test('future entries do not extend the current streak', () {
      final t = today();
      final history = {
        t.add(const Duration(days: 1)): 3,
        t: 1,
        t.subtract(const Duration(days: 1)): 1,
      };

      expect(calculateStreak(history, now: t), 2);
    });
  });
}
