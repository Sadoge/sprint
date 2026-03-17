import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/domain/models/app_settings.dart';
import 'package:sprint/presentation/history/history_viewmodel.dart';
import 'package:sprint/presentation/settings/settings_viewmodel.dart';
import 'package:sprint/presentation/timer/timer_viewmodel.dart';

import '../../helpers/test_helpers.dart';

void main() {
  test('build loads settings from repository', () async {
    final settingsRepository = FakeSettingsRepository(
      initialSettings: const AppSettings(
        sprintDuration: 25,
        soundEnabled: false,
      ),
    );

    final container = ProviderContainer(
      overrides: [
        settingsRepositoryProvider.overrideWith((ref) => settingsRepository),
      ],
    );
    addTearDown(container.dispose);

    expect(
      await container.read(settingsViewModelProvider.future),
      const AppSettings(sprintDuration: 25, soundEnabled: false),
    );
  });

  test(
    'setDuration saves updated settings and invalidates timer state',
    () async {
      final settingsRepository = FakeSettingsRepository();
      final sprintRepository = FakeSprintRepository(
        history: {DateTime(2026, 3, 17): 1},
        now: () => DateTime(2026, 3, 17, 10),
      );

      final container = ProviderContainer(
        overrides: [
          settingsRepositoryProvider.overrideWith((ref) => settingsRepository),
          sprintRepositoryProvider.overrideWith((ref) => sprintRepository),
          nowProvider.overrideWith(
            (ref) =>
                () => DateTime(2026, 3, 17, 10),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(timerViewModelProvider.future);
      await container.read(settingsViewModelProvider.future);
      await container.read(settingsViewModelProvider.notifier).setDuration(25);

      expect(settingsRepository.settings.sprintDuration, 25);
      expect(
        container.read(settingsViewModelProvider).value?.sprintDuration,
        25,
      );

      final refreshedTimerState = await container.read(
        timerViewModelProvider.future,
      );
      expect(refreshedTimerState.totalDuration, const Duration(minutes: 25));
    },
  );

  test('toggleSound flips and persists sound setting', () async {
    final settingsRepository = FakeSettingsRepository();
    final container = ProviderContainer(
      overrides: [
        settingsRepositoryProvider.overrideWith((ref) => settingsRepository),
      ],
    );
    addTearDown(container.dispose);

    await container.read(settingsViewModelProvider.future);
    await container.read(settingsViewModelProvider.notifier).toggleSound();

    expect(settingsRepository.settings.soundEnabled, isFalse);
    expect(
      container.read(settingsViewModelProvider).value?.soundEnabled,
      isFalse,
    );
  });

  test(
    'resetAllData clears sprint history and refreshes dependent providers',
    () async {
      final now = DateTime(2026, 3, 17, 10);
      final settingsRepository = FakeSettingsRepository();
      final sprintRepository = FakeSprintRepository(
        now: () => now,
        history: {DateTime(2026, 3, 17): 2, DateTime(2026, 3, 16): 1},
      );

      final container = ProviderContainer(
        overrides: [
          settingsRepositoryProvider.overrideWith((ref) => settingsRepository),
          sprintRepositoryProvider.overrideWith((ref) => sprintRepository),
          nowProvider.overrideWith(
            (ref) =>
                () => now,
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(timerViewModelProvider.future);
      await container.read(historyViewModelProvider.future);

      await container.read(settingsViewModelProvider.notifier).resetAllData();

      final timerState = await container.read(timerViewModelProvider.future);
      final historyState = await container.read(
        historyViewModelProvider.future,
      );

      expect(sprintRepository.clearAllCalls, 1);
      expect(timerState.todayCount, 0);
      expect(timerState.streak, 0);
      expect(historyState.totalSprints, 0);
      expect(historyState.activeDays, 0);
    },
  );
}
