import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/presentation/settings/settings_screen.dart';
import 'package:sprint/presentation/timer/timer_viewmodel.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(disableRuntimeFontFetching);

  testWidgets('updates duration and sound settings from user interaction', (
    tester,
  ) async {
    final settingsRepository = FakeSettingsRepository();

    await tester.pumpWidget(
      buildTestApp(
        const SettingsScreen(),
        overrides: [
          settingsRepositoryProvider.overrideWith((ref) => settingsRepository),
          sprintRepositoryProvider.overrideWith(
            (ref) => FakeSprintRepository(),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('25m'));
    await tester.pumpAndSettle();

    expect(settingsRepository.settings.sprintDuration, 25);

    await tester.tap(find.byType(CupertinoSwitch));
    await tester.pumpAndSettle();

    expect(settingsRepository.settings.soundEnabled, isFalse);
  });

  testWidgets('shows reset confirmation dialog and clears data on confirm', (
    tester,
  ) async {
    final now = DateTime(2026, 3, 17, 10);
    final sprintRepository = FakeSprintRepository(
      now: () => now,
      history: {DateTime(2026, 3, 17): 2},
    );

    await tester.pumpWidget(
      buildTestApp(
        const SettingsScreen(),
        overrides: [
          settingsRepositoryProvider.overrideWith(
            (ref) => FakeSettingsRepository(),
          ),
          sprintRepositoryProvider.overrideWith((ref) => sprintRepository),
          nowProvider.overrideWith(
            (ref) =>
                () => now,
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();

    expect(find.text('Reset all data?'), findsOneWidget);
    expect(
      find.text('This will permanently clear your streak and sprint history.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(sprintRepository.clearAllCalls, 0);

    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reset').last);
    await tester.pumpAndSettle();

    expect(sprintRepository.clearAllCalls, 1);
  });
}
