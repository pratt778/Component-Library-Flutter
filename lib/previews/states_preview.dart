import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

import 'preview_harness.dart';

@Preview(name: 'EmptyState')
Widget emptyState() => previewApp(
  EmptyState(
    icon: Icons.inbox_outlined,
    title: 'Nothing here yet',
    subtitle: 'New items will show up once they arrive.',
    action: PrimaryButton(label: 'Refresh', onPressed: () {}),
  ),
);

@Preview(name: 'IconMessageState — with retry')
Widget iconMessageState() => previewApp(
  IconMessageState(
    icon: Icons.bluetooth_disabled,
    message: 'No printer connected. Turn on Bluetooth and try again.',
    onRetry: () {},
    retryLabel: 'Retry',
  ),
);

@Preview(name: 'SegmentedFilterBar')
Widget segmentedFilterBar() => previewApp(
  Padding(
    padding: const EdgeInsets.all(16),
    child: SegmentedFilterBar(
      options: const ['All', 'Pending', 'Synced'],
      selectedOption: 'Pending',
      onSelect: (_) {},
    ),
  ),
);

@Preview(name: 'SegmentedFilterBar — overflow')
Widget segmentedFilterBarOverflow() => previewApp(
  Padding(
    padding: const EdgeInsets.all(16),
    child: SegmentedFilterBar(
      options: const [
        'All',
        'Pending',
        'Synced',
        'Failed',
        'Draft',
        'Archived',
      ],
      selectedOption: 'Synced',
      onSelect: (_) {},
      scrollLeftLabel: 'Scroll left',
      scrollRightLabel: 'Scroll right',
    ),
  ),
);

@Preview(name: 'FieldLabel')
Widget fieldLabel() => previewApp(
  const Padding(
    padding: EdgeInsets.all(16),
    child: FieldLabel(text: 'Full name'),
  ),
);

@Preview(name: 'BrandedLoader')
Widget brandedLoader() => previewCentered(
  const BrandedLoader(
    centerAsset: 'packages/component_library_flutter/assets/preview/center.svg',
    ringAsset: 'packages/component_library_flutter/assets/preview/ring.svg',
    size: 80,
  ),
);

@Preview(name: 'ShimmerBox')
Widget shimmerBox() =>
    previewCentered(const ShimmerBox(width: 200, height: 48));

@Preview(name: 'ShimmerListLoader')
Widget shimmerListLoader() => previewApp(const ShimmerListLoader(itemCount: 4));
