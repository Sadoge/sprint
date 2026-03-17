int calculateStreak(Map<DateTime, int> history, {DateTime? now}) {
  int streak = 0;
  DateTime day = now ?? DateTime.now();

  while (true) {
    final key = DateTime(day.year, day.month, day.day);
    if ((history[key] ?? 0) > 0) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    } else {
      break;
    }
  }

  return streak;
}
