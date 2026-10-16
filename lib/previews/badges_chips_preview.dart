import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

import 'preview_harness.dart';

@Preview(name: 'AppBadge — all variants')
Widget appBadgeVariants() => previewApp(
  Center(
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        AppBadge(label: 'success', variant: AppBadgeVariant.success),
        AppBadge(label: 'warning', variant: AppBadgeVariant.warning),
        AppBadge(label: 'info', variant: AppBadgeVariant.info),
        AppBadge(label: 'error', variant: AppBadgeVariant.error),
      ],
    ),
  ),
);

@Preview(name: 'AppChip — outlined')
Widget appChipOutlined() =>
    previewCentered(AppChip(label: 'Filter', icon: Icons.tune, onTap: () {}));

@Preview(name: 'AppChip — filled + active')
Widget appChipFilledActive() => previewApp(
  Center(
    child: Wrap(
      spacing: 12,
      children: [
        AppChip(
          label: 'Download',
          icon: Icons.download,
          filled: true,
          onTap: () {},
        ),
        AppChip(label: 'Sync', icon: Icons.sync, active: true, onTap: () {}),
        AppChip(
          label: 'Loading',
          icon: Icons.sync,
          isLoading: true,
          onTap: () {},
        ),
        const AppChip(label: '', icon: Icons.refresh, iconOnly: true),
      ],
    ),
  ),
);

@Preview(name: 'LabelValueChip')
Widget labelValueChip() =>
    previewCentered(const LabelValueChip(label: 'Adults', value: '12'));
