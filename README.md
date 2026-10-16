# Widget Components (Design System & UI Kit)

A production-ready Flutter component library, theme token contract, and UI kit. It combines clean package architecture (`lib/src/`) with modern design tokens, custom widgets, extensions, and utilities.

---

## Features

- 🎨 **Design Tokens & Theme Contract**:
  - `AppColorsExtension`: Custom semantic tokens (`cardShadow`, `surfaceLow`, etc.) with automatic fallback to standard `ColorScheme`.
  - `AppTheme`: Preconfigured `AppTheme.light()`, `AppTheme.dark()`, and `AppTheme.fromSeed()` helpers.
  - `AppSpacing`, `AppRadius`, and `AppDurations` scales.
  - `AppTypography`: Type scale definitions that inherit the host app's font family (no font family is hardcoded).
- 🧩 **Comprehensive Widget Library**:
  - **Actions**: `PrimaryButton`, `SecondaryButton`, `CircularActionButton`, `TextActionButton`, `ButtonGroup`.
  - **Inputs & Forms**: `AppInput` (floating label with underline), `AppDropdown`, `AppSearchBar`, `AppCheckbox`, `AppSwitchTile`, `AppSlider`, `AppRating`, `CountStepperField`, `ToggleRow`.
  - **Surfaces & Cards**: `AppCard` (with hero padding, shadow, border, and tap ripple), `AppTile`, `AppListItem`.
  - **Navigation**: `CustomAppBar` (router-agnostic), `AppNavigationBar` (Material 3 style), `CurvedBottomNav` / `FmBottomNav` (notch animation), `AppTabBar`, `AppDrawer`.
  - **Sheets & Dialogs**: `AppBottomSheet`, `FilterBottomSheetShell`, `PhotoSourceSheet`, `PickerSheet`, `ConfirmationDialog`, `AppAlertDialog`, `DragHandle`.
  - **Feedback & Loaders**: `AppToast` (top-sliding overlay), `ToastUtils` (Scaffold snackbar toasts), `BrandedLoader`, `ShimmerBox`, `ShimmerListLoader`, `AppProgressIndicator`, `CustomEmptyState`, `IconMessageState`.
  - **Indicators & Badges**: `AppBadge` (status pill), `AppNotificationBadge` (numerical/dot overlay on icons), `AppChip`, `LabelValueChip`.
- ⚡ **Extensions**:
  - `ContextX`: Responsive dimensions (`screenWidth`, `screenHeight`), `isDarkMode`, `showSnackBar`, `push`, `pop`, `unfocus`.
  - `DateTimeX`: `isToday`, `isYesterday`, `isTomorrow`, `startOfDay`, `endOfDay`, `addMonths`, `toRelativeLabel`.
  - `NumExtensions`: `formatWithCommas`, `roundTo`, `toPercentage`, `formatDuration`, `formatBytes`, and spacing helpers `16.h`, `12.w`.
  - `StringExtensions`: `capitalize`, `titleCase`, `isValidEmail`, `isValidUrl`, `truncate`, `toCamelCase`, `toSnakeCase`.
- 🛠️ **Utilities**:
  - `AppValidators`: Form field validation suite (`required`, `email`, `requiredEmail`, `phone`, `url`, `numeric`, `minLength`, `maxLength`, `compose`).
  - `Debouncer`: Input throttling and delayed execution for search-as-you-type.
  - `ToastUtils`: Themed instant toasts (success, error, info, warning).

---

## Getting Started

### 1. Import the Library

Import the main barrel file:

```dart
import 'package:component_library_flutter/component_library_flutter.dart';
```

*(Or via alias `package:component_library_flutter/component_library.dart`)*

### 2. Configure Theme (Optional)

You can use the built-in `AppTheme`:

```dart
MaterialApp(
  theme: AppTheme.light(seedColor: const Color(0xFF2563EB)),
  darkTheme: AppTheme.dark(seedColor: const Color(0xFF2563EB)),
  home: const HomeScreen(),
);
```

> **Note**: Even if your app uses standard `ThemeData.light()`, widgets will **never crash** — `context.appColors` automatically falls back to values derived from the active `ColorScheme`.

---

## Directory Structure

```
lib/
├── component_library_flutter.dart  # Main public API barrel file
├── component_library.dart          # Re-export alias
├── previews/                       # Interactive component preview catalog
└── src/
    ├── extensions/                 # Context, DateTime, Num, and String extensions
    ├── theme/                      # AppColorsExtension, AppTheme, AppTypography, AppSpacing
    ├── utils/                      # AppValidators, Debouncer, ToastUtils
    └── widgets/                    # All reusable UI components
```

---

## Running Tests

Run widget and unit tests:

```bash
flutter test
```
