import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:component_library_flutter/component_library_flutter.dart';
import 'package:component_library_flutter/previews/preview_theme.dart';

void main() {
  test('previewTheme registers an AppColorsExtension carrying the seed', () {
    const seed = Color(0xFF2196F3);
    final colors = previewTheme(seedColor: seed)
        .extension<AppColorsExtension>()!;
    expect(colors.primary, seed);
  });

  testWidgets('PrimaryButton renders its label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: previewTheme(),
        home: Scaffold(
          body: PrimaryButton(label: 'Continue', onPressed: () {}),
        ),
      ),
    );
    expect(find.text('Continue'), findsOneWidget);
  });
}
