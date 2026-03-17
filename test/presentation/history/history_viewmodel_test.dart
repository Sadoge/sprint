import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/presentation/history/history_viewmodel.dart';
import 'package:sprint/presentation/timer/timer_viewmodel.dart';

import '../../helpers/test_helpers.dart';

void main() {
  test('build composes history state from repository data', () async {
    final now = DateTime(2026, 3, 17, 10);
    final sprintRepository = FakeSprintRepository(
      now: () => now,
      history: {
        DateTime(2026, 3, 17): 2,
        DateTime(2026, 3, 16): 1,
        DateTime(2026, 3, 14): 1,
      },
    );

    final container = ProviderContainer(
      overrides: [
        sprintRepositoryProvider.overrideWith((ref) => sprintRepository),
        nowProvider.overrideWith(
          (ref) =>
              () => now,
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(historyViewModelProvider.future);

    expect(state.heatmapData, sprintRepository.historyView);
    expect(state.streak, 2);
    expect(state.todayCount, 2);
    expect(state.totalSprints, 4);
    expect(state.activeDays, 3);
  });
}
