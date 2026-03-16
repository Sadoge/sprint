import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'sprint_dao.dart';
import 'settings_dao.dart';

part 'app_database.g.dart';

class Sprints extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get durationMinutes => integer()();
}

class Settings extends Table {
  IntColumn get id => integer()();
  IntColumn get sprintDuration => integer().withDefault(const Constant(15))();
  BoolColumn get soundEnabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Sprints, Settings], daos: [SprintDao, SettingsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sprint.db'));
    return NativeDatabase.createInBackground(file);
  });
}
