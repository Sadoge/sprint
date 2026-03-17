import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/presentation/history/history_screen.dart';
import 'package:sprint/presentation/timer/timer_viewmodel.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(disableRuntimeFontFetching);

  testWidgets('renders history stats from repository data', (tester) async {
    final now = DateTime(2026, 3, 17, 10);

    await tester.pumpWidget(
      buildTestApp(
        const HistoryScreen(),
        overrides: [
          sprintRepositoryProvider.overrideWith(
            (ref) => FakeSprintRepository(
              now: () => now,
              history: {
                DateTime(2026, 3, 17): 2,
                DateTime(2026, 3, 16): 1,
                DateTime(2026, 3, 14): 1,
              },
            ),
          ),
          nowProvider.overrideWith(
            (ref) =>
                () => now,
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Last 30 days'), findsOneWidget);
    expect(find.text('Current streak'), findsOneWidget);
    expect(find.text('2 days'), findsOneWidget);
    expect(find.text('Sprints today'), findsOneWidget);
    expect(find.text('Total sprints'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('Active days'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('3+'), findsOneWidget);
  });
}
