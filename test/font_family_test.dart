import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

/// Regression coverage for the font-family contract: widgets must never
/// hardcode a font family (they previously forced Inter through
/// `GoogleFonts.inter`) — text has to resolve the font family the consuming
/// app configured on its [ThemeData].
void main() {
  const preferredFamily = 'PreferredTestFont';

  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.fromSeed(
      seedColor: const Color(0xFF2563EB),
      fontFamily: preferredFamily,
    ),
    home: Scaffold(body: Center(child: child)),
  );

  test('AppTheme.fromSeed stamps fontFamily onto the type tokens', () {
    final theme = AppTheme.fromSeed(
      seedColor: const Color(0xFF2563EB),
      fontFamily: preferredFamily,
    );

    expect(theme.textTheme.bodyMedium?.fontFamily, preferredFamily);
    expect(theme.textTheme.labelLarge?.fontFamily, preferredFamily);
    expect(theme.textTheme.displayLarge?.fontFamily, preferredFamily);
  });

  testWidgets('plain Text widgets inherit the app font family', (tester) async {
    await tester.pumpWidget(wrap(const SectionHeader(title: 'Summary')));

    final rich = tester.widget<RichText>(find.byType(RichText));
    expect(rich.text.style?.fontFamily, preferredFamily);
    expect(rich.text.style?.fontFamily, isNot('Inter'));
  });

  testWidgets('button labels inherit the app font family', (tester) async {
    await tester.pumpWidget(
      wrap(TextActionButton(label: 'Continue', onPressed: () {})),
    );

    final rich = tester.widget<RichText>(find.byType(RichText));
    expect(rich.text.style?.fontFamily, preferredFamily);
  });

  testWidgets('Text.rich runs inherit the app font family', (tester) async {
    await tester.pumpWidget(
      wrap(const LabelValueChip(label: 'Total', value: '42')),
    );

    final rich = tester.widget<RichText>(find.byType(RichText));
    expect(rich.text.style?.fontFamily, preferredFamily);
  });

  testWidgets('editable text inherits the app font family', (tester) async {
    await tester.pumpWidget(wrap(const AppInput(label: 'Email')));

    final editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.style.fontFamily, preferredFamily);
  });
}
