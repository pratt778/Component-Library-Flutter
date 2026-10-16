import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

import 'preview_harness.dart';

@Preview(name: 'AppCard')
Widget appCard() => previewApp(
  Padding(
    padding: const EdgeInsets.all(16),
    child: AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Card title'),
          SizedBox(height: 4),
          Text('Some supporting content goes here.'),
        ],
      ),
    ),
  ),
);

@Preview(name: 'FmListItem — initials')
Widget fmListItemInitials() => previewApp(
  const FmListItem(
    title: 'Ramesh Shrestha',
    subtitle: 'Ward 4 · Kathmandu',
    avatarText: 'RS',
  ),
);

@Preview(name: 'FmListItem — icon + badge')
Widget fmListItemIconBadge() => previewApp(
  FmListItem(
    title: 'Pending sync',
    subtitle: '3 records queued',
    avatarIcon: Icons.sync,
    badge: const AppBadge(label: 'PENDING', variant: AppBadgeVariant.warning),
    onTap: () {},
  ),
);

@Preview(name: 'ProfileAvatar')
Widget profileAvatar() => previewCentered(
  Builder(
    builder: (context) =>
        ProfileAvatar(colors: context.appColors, name: 'Jane Doe', size: 64),
  ),
);

@Preview(name: 'PhotoOptionCard')
Widget photoOptionCard() => previewApp(
  Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(
          child: PhotoOptionCard(
            icon: Icons.photo_camera_rounded,
            label: 'Camera',
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PhotoOptionCard(
            icon: Icons.photo_library_rounded,
            label: 'Gallery',
            onTap: () {},
          ),
        ),
      ],
    ),
  ),
);
