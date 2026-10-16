import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

import 'preview_theme.dart';

@Preview(name: 'FmBottomNav')
Widget fmBottomNav() => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: previewTheme(),
  home: Scaffold(
    body: const Center(child: Text('Screen content')),
    bottomNavigationBar: FmBottomNav(
      activeIndex: 0,
      tabs: const [
        (icon: Icons.list_alt, label: 'Demo'),
        (icon: Icons.settings, label: 'Settings'),
      ],
      onTap: (_) {},
    ),
  ),
);

// CustomAppBar handles back navigation with Navigator.maybePop() or custom callback.
@Preview(name: 'CustomAppBar')
Widget customAppBar() => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: previewTheme(),
  home: const Scaffold(
    appBar: CustomAppBar(title: 'Screen title'),
    body: SizedBox.shrink(),
  ),
);
