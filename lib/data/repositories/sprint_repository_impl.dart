import '../../domain/repositories/sprint_repository.dart';
import '../database/app_database.dart';
import '../database/sprint_dao.dart';

class SprintRepositoryImpl implements SprintRepository {
  final SprintDao _dao;
  final DateTime Function() _now;

  SprintRepositoryImpl(this._dao, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  @override
  Future<void> recordSprint(int durationMinutes) {
    return _dao.insertSprint(
      SprintsCompanion.insert(
        completedAt: _now(),
        durationMinutes: durationMinutes,
      ),
    );
  }

  @override
  Future<Map<DateTime, int>> getLast30Days() async {
    final counts = await _dao.getSprintCountsByDay(now: _now());
    final result = <DateTime, int>{};
    for (final entry in counts.entries) {
      final parts = entry.key.split('-');
      final date = DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
      result[date] = entry.value;
    }
    return result;
  }

  @override
  Future<int> getTotalSprints() => _dao.getTotalCount();

  @override
  Future<int> getActiveDays() => _dao.getActiveDayCount();

  @override
  Future<void> clearAll() => _dao.deleteAll();
}
