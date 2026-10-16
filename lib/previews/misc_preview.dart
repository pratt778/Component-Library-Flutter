import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

import 'preview_harness.dart';

@Preview(name: 'DashedBorderDecoration')
Widget dashedBorderDecoration() => previewCentered(
  Container(
    width: 160,
    height: 100,
    decoration: const DashedBorderDecoration(
      borderRadius: 12,
      color: Colors.grey,
      dashWidth: 6,
      dashSpace: 4,
      strokeWidth: 1.5,
    ),
    alignment: Alignment.center,
    child: const Text('Drop file here'),
  ),
);

@Preview(name: 'FilterSheetActionRow')
Widget filterSheetActionRow() => previewApp(
  Align(
    alignment: Alignment.bottomCenter,
    child: FilterSheetActionRow(
      resetLabel: 'Reset',
      searchLabel: 'Search',
      onReset: () {},
      onSearch: () {},
    ),
  ),
);

/// AppToast is overlay-triggered (`AppToast.showTop`), so there's nothing to
/// render directly — this demo fires one a frame after the preview mounts,
/// against its own `Overlay`, so you can see it appear and animate.
@Preview(name: 'AppToast')
Widget appToast() => previewApp(const _ToastDemo());

class _ToastDemo extends StatefulWidget {
  const _ToastDemo();

  @override
  State<_ToastDemo> createState() => _ToastDemoState();
}

class _ToastDemoState extends State<_ToastDemo> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      AppToast.showTop(
        Overlay.of(context),
        message: 'Saved successfully',
        icon: Icons.check_circle_outline,
      );
    });
  }

  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('AppToast fires on mount ↑'));
}
