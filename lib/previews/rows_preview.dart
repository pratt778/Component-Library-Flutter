import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

import 'preview_harness.dart';
import 'preview_theme.dart';

@Preview(name: 'SectionHeader')
Widget sectionHeader() => previewApp(
  Padding(
    padding: const EdgeInsets.all(16),
    child: SectionHeader(
      title: 'Recent activity',
      action: TextActionButton(label: 'See all', onPressed: () {}),
    ),
  ),
);

@Preview(name: 'LabelValueRow — side by side')
Widget labelValueRowHorizontal() => previewApp(
  const Padding(
    padding: EdgeInsets.all(16),
    child: LabelValueRow(label: 'Customer ID', value: 'CUST-00123'),
  ),
);

@Preview(name: 'LabelValueRow — stacked')
Widget labelValueRowVertical() => previewApp(
  const Padding(
    padding: EdgeInsets.all(16),
    child: LabelValueRow(
      label: 'Address',
      value: 'Ward 4, Kathmandu',
      vertical: true,
    ),
  ),
);

@Preview(name: 'LabeledStatColumn')
Widget labeledStatColumn() => previewApp(
  Container(
    color: kPreviewSeed,
    padding: const EdgeInsets.all(16),
    child: const LabeledStatColumn(
      label: 'Pending',
      value: '12',
      color: Colors.white,
      mutedColor: Color(0xB3FFFFFF),
    ),
  ),
);

@Preview(name: 'CurrencyRow — total')
Widget currencyRowTotal() => previewApp(
  const Padding(
    padding: EdgeInsets.all(16),
    child: CurrencyRow(label: 'Total', value: 'Rs. 8,850.00', total: true),
  ),
);

@Preview(name: 'ToggleRow')
Widget toggleRow() => previewApp(
  Padding(
    padding: const EdgeInsets.all(16),
    child: ToggleRow(
      label: 'Registered vehicle',
      value: true,
      onChanged: (_) {},
    ),
  ),
);

// BottomActionBar is meant to be a Scaffold's bottomNavigationBar, not
// centered content — build the MaterialApp/Scaffold directly here instead
// of going through previewApp (which already wraps its child in a Scaffold).
@Preview(name: 'BottomActionBar')
Widget bottomActionBar() => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: previewTheme(),
  home: Scaffold(
    body: const SizedBox.shrink(),
    bottomNavigationBar: BottomActionBar(
      totalLabel: 'Total',
      totalValue: 'Rs. 8,850.00',
      actions: [
        Expanded(
          child: SecondaryButton(
            label: 'Cancel',
            fullWidth: true,
            onPressed: () {},
          ),
        ),
        Expanded(
          child: PrimaryButton(
            label: 'Confirm',
            fullWidth: true,
            onPressed: () {},
          ),
        ),
      ],
    ),
  ),
);
