import 'package:drift/drift.dart';

import '../../domain/models/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../database/app_database.dart';
import '../database/settings_dao.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDao _dao;

  SettingsRepositoryImpl(this._dao);

  @override
  Future<AppSettings> getSettings() async {
    final row = await _dao.getSettings();
    if (row == null) {
      return const AppSettings();
    }
    return AppSettings(
      sprintDuration: row.sprintDuration,
      soundEnabled: row.soundEnabled,
    );
  }

  @override
  Future<void> saveSettings(AppSettings settings) {
    return _dao.upsertSettings(
      SettingsCompanion(
        sprintDuration: Value(settings.sprintDuration),
        soundEnabled: Value(settings.soundEnabled),
      ),
    );
  }
}
