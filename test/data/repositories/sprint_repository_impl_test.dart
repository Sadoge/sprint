import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/data/database/app_database.dart';
import 'package:sprint/data/repositories/sprint_repository_impl.dart';

void main() {
  late AppDatabase database;
  late DateTime now;
  late SprintRepositoryImpl repository;

  setUp(() {
    now = DateTime(2026, 3, 17, 12);
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = SprintRepositoryImpl(database.sprintDao, now: () => now);
  });

  tearDown(() async {
    await database.close();
  });

  test('recordSprint persists the current timestamp and duration', () async {
    await repository.recordSprint(25);

    final rows = await database.select(database.sprints).get();

    expect(rows, hasLength(1));
    expect(rows.single.completedAt, now);
    expect(rows.single.durationMinutes, 25);
  });

  test('getLast30Days returns normalized date keys', () async {
    await database.sprintDao.insertSprint(
      SprintsCompanion.insert(
        completedAt: DateTime(2026, 3, 17, 8),
        durationMinutes: 15,
      ),
    );
    await database.sprintDao.insertSprint(
      SprintsCompanion.insert(
        completedAt: DateTime(2026, 3, 17, 9),
        durationMinutes: 15,
      ),
    );
    await database.sprintDao.insertSprint(
      SprintsCompanion.insert(
        completedAt: DateTime(2026, 3, 16, 9),
        durationMinutes: 15,
      ),
    );

    final result = await repository.getLast30Days();

    expect(result, {DateTime(2026, 3, 17): 2, DateTime(2026, 3, 16): 1});
  });

  test('delegates total count, active days, and clearing', () async {
    await repository.recordSprint(15);
    now = DateTime(2026, 3, 16, 12);
    await repository.recordSprint(15);

    expect(await repository.getTotalSprints(), 2);
    expect(await repository.getActiveDays(), 2);

    await repository.clearAll();

    expect(await repository.getTotalSprints(), 0);
    expect(await repository.getActiveDays(), 0);
  });
}
