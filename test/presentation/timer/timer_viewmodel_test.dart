import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/domain/models/app_settings.dart';
import 'package:sprint/domain/models/timer_status.dart';
import 'package:sprint/presentation/history/history_viewmodel.dart';
import 'package:sprint/presentation/timer/timer_viewmodel.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('build hydrates initial timer state from settings and history', (
    tester,
  ) async {
    final now = DateTime(2026, 3, 17, 10);
    final settingsRepository = FakeSettingsRepository(
      initialSettings: const AppSettings(
        sprintDuration: 25,
        soundEnabled: true,
      ),
    );
    final sprintRepository = FakeSprintRepository(
      now: () => now,
      history: {DateTime(2026, 3, 17): 2, DateTime(2026, 3, 16): 1},
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWith((ref) => settingsRepository),
          sprintRepositoryProvider.overrideWith((ref) => sprintRepository),
          nowProvider.overrideWith(
            (ref) =>
                () => now,
          ),
          completionSoundPlayerProvider.overrideWith(
            (ref) => FakeCompletionSoundPlayer(),
          ),
        ],
        child: const MaterialApp(home: SizedBox()),
      ),
    );

    final container = ProviderScope.containerOf(
      tester.element(find.byType(SizedBox)),
    );
    final subscription = container.listen(timerViewModelProvider, (_, __) {});
    addTearDown(subscription.close);
    final state = await container.read(timerViewModelProvider.future);

    expect(state.status, TimerStatus.idle);
    expect(state.totalDuration, const Duration(minutes: 25));
    expect(state.timeRemaining, const Duration(minutes: 25));
    expect(state.todayCount, 2);
    expect(state.streak, 2);
  });

  testWidgets('start counts down and stop resets to idle', (tester) async {
    final now = DateTime(2026, 3, 17, 10);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWith(
            (ref) => FakeSettingsRepository(),
          ),
          sprintRepositoryProvider.overrideWith(
            (ref) => FakeSprintRepository(now: () => now),
          ),
          nowProvider.overrideWith(
            (ref) =>
                () => now,
          ),
          completionSoundPlayerProvider.overrideWith(
            (ref) => FakeCompletionSoundPlayer(),
          ),
        ],
        child: const MaterialApp(home: SizedBox()),
      ),
    );

    final container = ProviderScope.containerOf(
      tester.element(find.byType(SizedBox)),
    );
    final subscription = container.listen(timerViewModelProvider, (_, __) {});
    addTearDown(subscription.close);
    await container.read(timerViewModelProvider.future);

    container.read(timerViewModelProvider.notifier).start();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(container.read(timerViewModelProvider).value, isNotNull);
    expect(
      container.read(timerViewModelProvider).value?.status,
      TimerStatus.running,
    );
    expect(
      container.read(timerViewModelProvider).value?.timeRemaining,
      const Duration(minutes: 14, seconds: 59),
    );

    container.read(timerViewModelProvider.notifier).stop();
    await tester.pump();

    expect(
      container.read(timerViewModelProvider).value?.status,
      TimerStatus.idle,
    );
    expect(
      container.read(timerViewModelProvider).value?.timeRemaining,
      const Duration(minutes: 15),
    );
  });

  testWidgets(
    'completion records sprint, updates history, plays sound, and resets',
    (tester) async {
      final now = DateTime(2026, 3, 17, 10);
      final settingsRepository = FakeSettingsRepository(
        initialSettings: const AppSettings(
          sprintDuration: 0,
          soundEnabled: true,
        ),
      );
      final sprintRepository = FakeSprintRepository(now: () => now);
      final soundPlayer = FakeCompletionSoundPlayer();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsRepositoryProvider.overrideWith(
              (ref) => settingsRepository,
            ),
            sprintRepositoryProvider.overrideWith((ref) => sprintRepository),
            nowProvider.overrideWith(
              (ref) =>
                  () => now,
            ),
            completionSoundPlayerProvider.overrideWith((ref) => soundPlayer),
          ],
          child: const MaterialApp(home: SizedBox()),
        ),
      );

      final container = ProviderScope.containerOf(
        tester.element(find.byType(SizedBox)),
      );
      final timerSubscription = container.listen(
        timerViewModelProvider,
        (_, __) {},
      );
      final historySubscription = container.listen(
        historyViewModelProvider,
        (_, __) {},
      );
      addTearDown(timerSubscription.close);
      addTearDown(historySubscription.close);
      await container.read(timerViewModelProvider.future);
      await container.read(historyViewModelProvider.future);

      container.read(timerViewModelProvider.notifier).start();
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(
        container.read(timerViewModelProvider).value?.status,
        TimerStatus.completed,
      );
      expect(container.read(timerViewModelProvider).value?.todayCount, 1);
      expect(container.read(timerViewModelProvider).value?.streak, 1);
      expect(sprintRepository.recordedDurations, [0]);
      expect(soundPlayer.playCalls, 1);

      final historyState = await container.read(
        historyViewModelProvider.future,
      );
      expect(historyState.totalSprints, 1);
      expect(historyState.todayCount, 1);

      await tester.pump(const Duration(seconds: 2));

      expect(
        container.read(timerViewModelProvider).value?.status,
        TimerStatus.idle,
      );
      expect(
        container.read(timerViewModelProvider).value?.timeRemaining,
        Duration.zero,
      );
    },
  );

  testWidgets('completion does not play sound when disabled', (tester) async {
    final now = DateTime(2026, 3, 17, 10);
    final soundPlayer = FakeCompletionSoundPlayer();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWith(
            (ref) => FakeSettingsRepository(
              initialSettings: const AppSettings(
                sprintDuration: 0,
                soundEnabled: false,
              ),
            ),
          ),
          sprintRepositoryProvider.overrideWith(
            (ref) => FakeSprintRepository(now: () => now),
          ),
          nowProvider.overrideWith(
            (ref) =>
                () => now,
          ),
          completionSoundPlayerProvider.overrideWith((ref) => soundPlayer),
        ],
        child: const MaterialApp(home: SizedBox()),
      ),
    );

    final container = ProviderScope.containerOf(
      tester.element(find.byType(SizedBox)),
    );
    final subscription = container.listen(timerViewModelProvider, (_, __) {});
    addTearDown(subscription.close);
    await container.read(timerViewModelProvider.future);
    container.read(timerViewModelProvider.notifier).start();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 2));

    expect(soundPlayer.playCalls, 0);
  });
}
