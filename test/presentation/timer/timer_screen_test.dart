import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sprint/domain/models/app_settings.dart';
import 'package:sprint/presentation/timer/timer_screen.dart';
import 'package:sprint/presentation/timer/timer_viewmodel.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(disableRuntimeFontFetching);

  testWidgets('renders timer state and responds to play/stop taps', (
    tester,
  ) async {
    final now = DateTime(2026, 3, 17, 10);

    await tester.pumpWidget(
      buildTestApp(
        const TimerScreen(),
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
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('15:00'), findsOneWidget);
    expect(find.text('0 sprints'), findsOneWidget);
    expect(find.byIcon(LucideIcons.play), findsOneWidget);

    await tester.tap(find.byIcon(LucideIcons.play));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('14:59'), findsOneWidget);
    expect(find.byIcon(LucideIcons.x), findsOneWidget);

    await tester.tap(find.byIcon(LucideIcons.x));
    await tester.pump();

    expect(find.text('15:00'), findsOneWidget);
    expect(find.byIcon(LucideIcons.play), findsOneWidget);
  });

  testWidgets(
    'shows completion checkmark after a zero-minute sprint finishes',
    (tester) async {
      final now = DateTime(2026, 3, 17, 10);

      await tester.pumpWidget(
        buildTestApp(
          const TimerScreen(),
          overrides: [
            settingsRepositoryProvider.overrideWith(
              (ref) => FakeSettingsRepository(
                initialSettings: const AppSettings(sprintDuration: 0),
              ),
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
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(LucideIcons.play));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byIcon(LucideIcons.check), findsOneWidget);
      expect(find.text('1 sprints'), findsOneWidget);

      await tester.pump(const Duration(seconds: 2));
    },
  );
}
