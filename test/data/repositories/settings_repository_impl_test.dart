import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/data/database/app_database.dart';
import 'package:sprint/data/repositories/settings_repository_impl.dart';
import 'package:sprint/domain/models/app_settings.dart';

void main() {
  late AppDatabase database;
  late SettingsRepositoryImpl repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = SettingsRepositoryImpl(database.settingsDao);
  });

  tearDown(() async {
    await database.close();
  });

  test('returns default settings when no row exists', () async {
    expect(await repository.getSettings(), const AppSettings());
  });

  test('saves and reloads settings via single upsert row', () async {
    const settings = AppSettings(sprintDuration: 25, soundEnabled: false);

    await repository.saveSettings(settings);
    final loaded = await repository.getSettings();
    final row = await database.settingsDao.getSettings();

    expect(loaded, settings);
    expect(row?.id, 1);
    expect(row?.sprintDuration, 25);
    expect(row?.soundEnabled, isFalse);
  });

  test('subsequent saves update the same row', () async {
    await repository.saveSettings(
      const AppSettings(sprintDuration: 10, soundEnabled: true),
    );
    await repository.saveSettings(
      const AppSettings(sprintDuration: 15, soundEnabled: false),
    );

    final rows = await database.select(database.settings).get();

    expect(rows, hasLength(1));
    expect(rows.single.sprintDuration, 15);
    expect(rows.single.soundEnabled, isFalse);
  });
}
