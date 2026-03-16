import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/utils/streak_calculator.dart';

void main() {
  group('calculateStreak', () {
    DateTime today() {
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day);
    }

    test('returns 0 for empty history', () {
      expect(calculateStreak({}), 0);
    });

    test('returns 1 for single day (today)', () {
      final history = {today(): 2};
      expect(calculateStreak(history), 1);
    });

    test('returns correct multi-day streak', () {
      final t = today();
      final history = {
        t: 1,
        t.subtract(const Duration(days: 1)): 3,
        t.subtract(const Duration(days: 2)): 1,
        t.subtract(const Duration(days: 3)): 2,
      };
      expect(calculateStreak(history), 4);
    });

    test('stops at broken streak', () {
      final t = today();
      final history = {
        t: 1,
        t.subtract(const Duration(days: 1)): 1,
        // day 2 missing
        t.subtract(const Duration(days: 3)): 5,
      };
      expect(calculateStreak(history), 2);
    });

    test('returns 0 if streak broken yesterday (no today entry)', () {
      final t = today();
      final history = {
        t.subtract(const Duration(days: 1)): 1,
        t.subtract(const Duration(days: 2)): 1,
      };
      // Today has no entry, so streak is 0
      expect(calculateStreak(history), 0);
    });

    test('ignores entries with count of 0', () {
      final t = today();
      final history = {
        t: 0,
        t.subtract(const Duration(days: 1)): 2,
      };
      expect(calculateStreak(history), 0);
    });
  });
}
