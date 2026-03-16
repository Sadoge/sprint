import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/app_settings.dart';
import '../history/history_viewmodel.dart';
import '../timer/timer_viewmodel.dart';

part 'settings_viewmodel.g.dart';

@riverpod
class SettingsViewModel extends _$SettingsViewModel {
  @override
  Future<AppSettings> build() async {
    final settingsRepo = ref.watch(settingsRepositoryProvider);
    return settingsRepo.getSettings();
  }

  Future<void> setDuration(int minutes) async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final current = state.valueOrNull ?? const AppSettings();
    final updated = current.copyWith(sprintDuration: minutes);
    await settingsRepo.saveSettings(updated);
    state = AsyncData(updated);
    ref.invalidate(timerViewModelProvider);
  }

  Future<void> toggleSound() async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final current = state.valueOrNull ?? const AppSettings();
    final updated = current.copyWith(soundEnabled: !current.soundEnabled);
    await settingsRepo.saveSettings(updated);
    state = AsyncData(updated);
  }

  Future<void> resetAllData() async {
    final sprintRepo = ref.read(sprintRepositoryProvider);
    await sprintRepo.clearAll();
    ref.invalidate(timerViewModelProvider);
    ref.invalidate(historyViewModelProvider);
  }
}
