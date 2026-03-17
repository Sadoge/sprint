import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/design_system/components/duration_pill_selector.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  setUpAll(disableRuntimeFontFetching);

  testWidgets('emits selected duration when a pill is tapped', (tester) async {
    int? selectedMinutes;

    await tester.pumpWidget(
      buildTestApp(
        DurationPillSelector(
          selected: 15,
          onChanged: (minutes) => selectedMinutes = minutes,
        ),
      ),
    );

    await tester.tap(find.text('25m'));
    await tester.pumpAndSettle();

    expect(selectedMinutes, 25);
  });
}
