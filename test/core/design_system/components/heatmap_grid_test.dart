import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/design_system/components/heatmap_grid.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  setUpAll(disableRuntimeFontFetching);

  testWidgets('renders legend and day tooltips', (tester) async {
    final today = normalizeDate(DateTime.now());

    await tester.pumpWidget(
      buildTestApp(
        HeatmapGrid(
          data: {today: 2, today.subtract(const Duration(days: 1)): 1},
        ),
      ),
    );

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3+'), findsOneWidget);

    final tooltipMessage = '${today.month}/${today.day}: 2 sprints';
    final yesterday = today.subtract(const Duration(days: 1));
    final yesterdayTooltip = '${yesterday.month}/${yesterday.day}: 1 sprints';

    expect(find.byTooltip(tooltipMessage), findsOneWidget);
    expect(find.byTooltip(yesterdayTooltip), findsOneWidget);
  });
}
