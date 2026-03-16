import 'package:drift/drift.dart';
import 'app_database.dart';

part 'sprint_dao.g.dart';

@DriftAccessor(tables: [Sprints])
class SprintDao extends DatabaseAccessor<AppDatabase> with _$SprintDaoMixin {
  SprintDao(super.db);

  Future<void> insertSprint(SprintsCompanion sprint) {
    return into(sprints).insert(sprint);
  }

  Future<Map<String, int>> getSprintCountsByDay() async {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    final query = select(sprints)
      ..where((s) => s.completedAt.isBiggerOrEqualValue(thirtyDaysAgo));

    final results = await query.get();
    final counts = <String, int>{};
    for (final row in results) {
      final date = row.completedAt;
      final key = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      counts[key] = (counts[key] ?? 0) + 1;
    }
    return counts;
  }

  Future<int> getTotalCount() async {
    final count = countAll();
    final query = selectOnly(sprints)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  Future<int> getActiveDayCount() async {
    final query = selectOnly(sprints, distinct: true)
      ..addColumns([sprints.completedAt]);
    final results = await query.get();

    final uniqueDays = <String>{};
    for (final row in results) {
      final date = row.read(sprints.completedAt);
      if (date != null) {
        uniqueDays.add('${date.year}-${date.month}-${date.day}');
      }
    }
    return uniqueDays.length;
  }

  Future<void> deleteAll() {
    return delete(sprints).go();
  }
}
