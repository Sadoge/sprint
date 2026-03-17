import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/data/database/app_database.dart';

void main() {
  late AppDatabase database;
  late DateTime now;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    now = DateTime(2026, 3, 17, 12);
  });

  tearDown(() async {
    await database.close();
  });

  Future<void> insertSprint(DateTime completedAt, {int durationMinutes = 15}) {
    return database.sprintDao.insertSprint(
      SprintsCompanion.insert(
        completedAt: completedAt,
        durationMinutes: durationMinutes,
      ),
    );
  }

  test('groups multiple sprints on the same day', () async {
    await insertSprint(DateTime(2026, 3, 17, 9));
    await insertSprint(DateTime(2026, 3, 17, 15));
    await insertSprint(DateTime(2026, 3, 16, 18));

    final counts = await database.sprintDao.getSprintCountsByDay(now: now);

    expect(counts, {'2026-03-17': 2, '2026-03-16': 1});
  });

  test('excludes rows older than the rolling 30 day cutoff', () async {
    await insertSprint(DateTime(2026, 2, 15, 11, 59, 59));
    await insertSprint(DateTime(2026, 2, 15, 12));
    await insertSprint(DateTime(2026, 3, 17, 8));

    final counts = await database.sprintDao.getSprintCountsByDay(now: now);

    expect(counts.containsKey('2026-02-15'), isTrue);
    expect(counts['2026-02-15'], 1);
    expect(counts['2026-03-17'], 1);
  });

  test('returns total and active day counts', () async {
    await insertSprint(DateTime(2026, 3, 17, 9));
    await insertSprint(DateTime(2026, 3, 17, 12));
    await insertSprint(DateTime(2026, 3, 16, 12));

    expect(await database.sprintDao.getTotalCount(), 3);
    expect(await database.sprintDao.getActiveDayCount(), 2);
  });

  test('deleteAll removes all persisted sprints', () async {
    await insertSprint(DateTime(2026, 3, 17, 9));
    await insertSprint(DateTime(2026, 3, 16, 9));

    await database.sprintDao.deleteAll();

    expect(await database.sprintDao.getTotalCount(), 0);
    expect(await database.sprintDao.getActiveDayCount(), 0);
    expect(await database.sprintDao.getSprintCountsByDay(now: now), isEmpty);
  });
}
