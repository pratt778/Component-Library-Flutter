import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

import 'preview_harness.dart';

@Preview(name: 'DragHandle')
Widget dragHandle() => previewApp(
  const Align(alignment: Alignment.topCenter, child: DragHandle()),
);

@Preview(name: 'PickerOptionTile — selected')
Widget pickerOptionTileSelected() => previewApp(
  Padding(
    padding: const EdgeInsets.all(16),
    child: PickerOptionTile(
      labelEn: 'Kathmandu',
      labelNp: 'काठमाडौं',
      isSelected: true,
      onTap: () {},
      onClear: () {},
      clearTooltip: 'Clear',
    ),
  ),
);

@Preview(name: 'PickerOptionTile — unselected')
Widget pickerOptionTileUnselected() => previewApp(
  Padding(
    padding: const EdgeInsets.all(16),
    child: PickerOptionTile(
      labelEn: 'Bhaktapur',
      labelNp: 'भक्तपुर',
      isSelected: false,
      onTap: () {},
    ),
  ),
);

@Preview(name: 'FilterSheetHeader')
Widget filterSheetHeader() => previewApp(
  FilterSheetHeader(
    title: 'Filter customers',
    onClose: () {},
    closeTooltip: 'Close',
  ),
);

@Preview(name: 'ConfirmationDialog')
Widget confirmationDialog() => previewApp(
  const ConfirmationDialog(
    title: 'Log out?',
    message: 'You will need to sign in again to continue.',
    confirmLabel: 'Log out',
    cancelLabel: 'Cancel',
    destructive: true,
  ),
);

// Full-height sheets: DraggableScrollableSheet needs a bounded-height
// ancestor — a Scaffold body already provides that, so previewApp works
// unmodified here.
@Preview(name: 'PickerSheet')
Widget pickerSheet() => previewApp(
  PickerSheet<String>(
    title: 'Select district',
    options: const [
      PickerOption(value: 'ktm', labelEn: 'Kathmandu', labelNp: 'काठमाडौं'),
      PickerOption(value: 'bkt', labelEn: 'Bhaktapur', labelNp: 'भक्तपुर'),
      PickerOption(value: 'lpr', labelEn: 'Lalitpur', labelNp: 'ललितपुर'),
    ],
    selected: 'ktm',
    searchHint: 'Search',
    noResultsLabel: 'No results found',
  ),
);

@Preview(name: 'PhotoSourceSheet')
Widget photoSourceSheet() => previewApp(
  const PhotoSourceSheet(
    canRemove: true,
    title: 'Update photo',
    cameraLabel: 'Camera',
    galleryLabel: 'Gallery',
    removePhotoLabel: 'Remove photo',
  ),
);

@Preview(name: 'FilterBottomSheetShell')
Widget filterBottomSheetShell() => previewApp(
  FilterBottomSheetShell(
    title: 'Filter customers',
    resetLabel: 'Reset',
    searchLabel: 'Search',
    closeTooltip: 'Close',
    onReset: () {},
    onApply: () {},
    formBuilder: (scrollController) => ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      children: const [
        AppInput(label: 'Customer ID'),
        SizedBox(height: 12),
        AppInput(label: 'Phone number'),
      ],
    ),
  ),
);
