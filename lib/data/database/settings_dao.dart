import 'package:drift/drift.dart';
import 'app_database.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [Settings])
class SettingsDao extends DatabaseAccessor<AppDatabase> with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Future<Setting?> getSettings() async {
    final query = select(settings)
      ..where((s) => s.id.equals(1));
    final results = await query.get();
    return results.isEmpty ? null : results.first;
  }

  Future<void> upsertSettings(SettingsCompanion data) async {
    await into(settings).insertOnConflictUpdate(
      data.copyWith(id: const Value(1)),
    );
  }
}
