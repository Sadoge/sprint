import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/main.dart';
import 'package:sprint/presentation/timer/timer_viewmodel.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(disableRuntimeFontFetching);

  testWidgets('app boots on timer route and navigates between tabs', (
    tester,
  ) async {
    final now = DateTime(2026, 3, 17, 10);
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

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
        child: const SprintApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('SPRINT'), findsOneWidget);
    expect(find.text('focus timer'), findsOneWidget);

    await tester.tap(find.text('HISTORY'));
    await tester.pumpAndSettle();
    expect(find.text('Last 30 days'), findsOneWidget);

    await tester.tap(find.text('SETTINGS'));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('TIMER'));
    await tester.pumpAndSettle();
    expect(find.text('focus timer'), findsOneWidget);
  });
}
