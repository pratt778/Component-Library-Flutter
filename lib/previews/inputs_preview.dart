import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:component_library_flutter/component_library_flutter.dart';

import 'preview_harness.dart';

@Preview(name: 'AppInput — empty')
Widget appInputEmpty() => previewApp(
  const Padding(
    padding: EdgeInsets.all(16),
    child: AppInput(label: 'Full name', hint: 'Jane Doe'),
  ),
);

@Preview(name: 'AppInput — filled + required')
Widget appInputFilled() {
  final controller = TextEditingController(text: 'Jane Doe');
  return previewApp(
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppInput(
        label: 'Full name',
        controller: controller,
        isRequired: true,
      ),
    ),
  );
}

@Preview(name: 'AppInput — error')
Widget appInputError() => previewApp(
  const Padding(
    padding: EdgeInsets.all(16),
    child: AppInput(label: 'Phone number', errorText: '10 digits required'),
  ),
);

@Preview(name: 'AppDropdown — empty')
Widget appDropdownEmpty() => previewApp(
  const Padding(
    padding: EdgeInsets.all(16),
    child: AppDropdown(label: 'District', onTap: null),
  ),
);

@Preview(name: 'AppDropdown — selected + clearable')
Widget appDropdownSelected() => previewApp(
  Padding(
    padding: const EdgeInsets.all(16),
    child: AppDropdown(
      label: 'District',
      value: 'Kathmandu',
      onTap: () {},
      onClear: () {},
    ),
  ),
);

@Preview(name: 'CountStepperField')
Widget countStepperField() => previewCentered(
  CountStepperField(label: 'ADULTS', value: 3, onChanged: (_) {}),
);
