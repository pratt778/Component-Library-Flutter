import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

import 'preview_harness.dart';

@Preview(name: 'PrimaryButton — enabled')
Widget primaryButtonEnabled() =>
    previewCentered(PrimaryButton(label: 'Continue', onPressed: () {}));

@Preview(name: 'PrimaryButton — disabled')
Widget primaryButtonDisabled() =>
    previewCentered(const PrimaryButton(label: 'Continue', onPressed: null));

@Preview(name: 'PrimaryButton — loading')
Widget primaryButtonLoading() => previewCentered(
  PrimaryButton(
    label: 'Continue',
    isLoading: true,
    loadingLabel: 'Saving…',
    onPressed: () {},
  ),
);

@Preview(name: 'PrimaryButton — dark')
Widget primaryButtonDark() => previewCentered(
  PrimaryButton(label: 'Continue', onPressed: () {}),
  dark: true,
);

@Preview(name: 'SecondaryButton')
Widget secondaryButton() => previewCentered(
  SecondaryButton(label: 'Cancel', leadingIcon: Icons.close, onPressed: () {}),
);

@Preview(name: 'TextActionButton')
Widget textActionButton() => previewCentered(
  TextActionButton(
    label: 'Learn more',
    leadingIcon: Icons.info_outline,
    onPressed: () {},
  ),
);

@Preview(name: 'CircularActionButton')
Widget circularActionButton() => previewCentered(
  CircularActionButton(
    icon: const Icon(Icons.add, color: Colors.white),
    onPressed: () {},
  ),
);

@Preview(name: 'CircularActionButton — loading')
Widget circularActionButtonLoading() => previewCentered(
  CircularActionButton(
    icon: const Icon(Icons.add, color: Colors.white),
    isLoading: true,
    onPressed: () {},
  ),
);
