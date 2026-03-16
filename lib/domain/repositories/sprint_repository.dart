abstract class SprintRepository {
  Future<void> recordSprint(int durationMinutes);
  Future<Map<DateTime, int>> getLast30Days();
  Future<int> getTotalSprints();
  Future<int> getActiveDays();
  Future<void> clearAll();
}
