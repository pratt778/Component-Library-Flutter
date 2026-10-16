import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

void main() {
  Widget wrap(Widget child, {bool useAppTheme = true}) {
    return MaterialApp(
      theme: useAppTheme ? AppTheme.light() : ThemeData.light(),
      home: Scaffold(body: child),
    );
  }

  testWidgets('AppColorsExtension safe fallback works with bare ThemeData',
      (tester) async {
    late AppColorsExtension resolvedColors;

    await tester.pumpWidget(
      wrap(
        Builder(
          builder: (context) {
            resolvedColors = context.appColors;
            return const SizedBox();
          },
        ),
        useAppTheme: false,
      ),
    );

    // Should resolve safely without throwing null assertion error
    expect(resolvedColors, isNotNull);
    expect(resolvedColors.primary, isNotNull);
  });

  testWidgets('AppRating renders correct number of stars and responds to tap',
      (tester) async {
    double selectedRating = 0;

    await tester.pumpWidget(
      wrap(
        AppRating(
          value: 3.0,
          onChanged: (rating) => selectedRating = rating,
        ),
      ),
    );

    expect(find.byType(AppRating), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNWidgets(3));
    expect(find.byIcon(Icons.star_border), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.star_border).first);
    expect(selectedRating, 4.0);
  });

  testWidgets('AppSlider renders label and value', (tester) async {
    await tester.pumpWidget(
      wrap(
        AppSlider(
          value: 40,
          label: 'Volume',
          onChanged: (_) {},
        ),
      ),
    );

    expect(find.text('Volume'), findsOneWidget);
    expect(find.text('40'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
  });

  testWidgets('AppCheckbox renders and triggers callback', (tester) async {
    bool? isChecked = false;

    await tester.pumpWidget(
      wrap(
        StatefulBuilder(
          builder: (context, setState) {
            return AppCheckbox(
              value: isChecked ?? false,
              label: 'Accept terms',
              onChanged: (val) => setState(() => isChecked = val),
            );
          },
        ),
      ),
    );

    expect(find.text('Accept terms'), findsOneWidget);
    await tester.tap(find.text('Accept terms'));
    expect(isChecked, isTrue);
  });

  testWidgets('AppSwitchTile renders and switches state', (tester) async {
    bool isToggled = false;

    await tester.pumpWidget(
      wrap(
        StatefulBuilder(
          builder: (context, setState) {
            return AppSwitchTile(
              value: isToggled,
              title: 'Notifications',
              subtitle: 'Receive daily updates',
              onChanged: (val) => setState(() => isToggled = val),
            );
          },
        ),
      ),
    );

    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Receive daily updates'), findsOneWidget);

    await tester.tap(find.text('Notifications'));
    expect(isToggled, isTrue);
  });

  testWidgets('AppSearchBar allows typing and clearing', (tester) async {
    String query = '';
    final controller = TextEditingController();

    await tester.pumpWidget(
      wrap(
        AppSearchBar(
          controller: controller,
          onChanged: (val) => query = val,
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Flutter');
    expect(query, 'Flutter');

    expect(find.byIcon(Icons.close), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    expect(query, '');
  });

  testWidgets('AppNotificationBadge overlays count and dot correctly',
      (tester) async {
    await tester.pumpWidget(
      wrap(
        const Column(
          children: [
            AppNotificationBadge(
              count: 5,
              child: Icon(Icons.notifications),
            ),
            AppNotificationBadge(
              showDot: true,
              child: Icon(Icons.mail),
            ),
          ],
        ),
      ),
    );

    expect(find.text('5'), findsOneWidget);
    expect(find.byIcon(Icons.notifications), findsOneWidget);
    expect(find.byIcon(Icons.mail), findsOneWidget);
  });

  testWidgets('CustomAppBar renders title and back button with custom callback',
      (tester) async {
    bool backPressed = false;

    await tester.pumpWidget(
      wrap(
        CustomAppBar(
          title: 'Settings',
          onBackPressed: () => backPressed = true,
        ),
      ),
    );

    expect(find.text('Settings'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    expect(backPressed, isTrue);
  });

  testWidgets('AppCard renders child and triggers onTap when supplied',
      (tester) async {
    bool cardTapped = false;

    await tester.pumpWidget(
      wrap(
        AppCard(
          onTap: () => cardTapped = true,
          child: const Text('Card Content'),
        ),
      ),
    );

    expect(find.text('Card Content'), findsOneWidget);
    await tester.tap(find.text('Card Content'));
    expect(cardTapped, isTrue);
  });
}
