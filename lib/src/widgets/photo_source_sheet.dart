import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import 'drag_handle.dart';
import 'photo_option_card.dart';

/// Three-state result of [PhotoSourceSheet]. Lets the caller tell "tapped
/// Remove" apart from "dismissed the sheet" — both of which would otherwise
/// arrive as a bare `null` from `showModalBottomSheet`.
enum PhotoSheetAction { camera, gallery, remove }

/// Compact bottom sheet for choosing a photo source — Camera and Gallery as
/// two side-by-side cards, with a "Remove photo" action shown only when
/// [canRemove] is true.
///
/// Unlike the app-owned version this was extracted from, [title],
/// [cameraLabel], [galleryLabel] are required and [removePhotoLabel] is
/// required whenever [canRemove] is true — a shared package can't read any
/// one app's generated `AppLocalizations` class, so the caller resolves its
/// own localized copy and passes it in.
class PhotoSourceSheet extends StatelessWidget {
  const PhotoSourceSheet({
    super.key,
    required this.canRemove,
    required this.title,
    required this.cameraLabel,
    required this.galleryLabel,
    this.removePhotoLabel,
  }) : assert(
         !canRemove || removePhotoLabel != null,
         'removePhotoLabel is required when canRemove is true',
       );

  final bool canRemove;
  final String title;
  final String cameraLabel;
  final String galleryLabel;
  final String? removePhotoLabel;

  /// Shows the sheet and resolves to the chosen [PhotoSheetAction], or
  /// `null` when the user dismisses it.
  static Future<PhotoSheetAction?> show(
    BuildContext context, {
    required bool canRemove,
    required String title,
    required String cameraLabel,
    required String galleryLabel,
    String? removePhotoLabel,
  }) {
    return showModalBottomSheet<PhotoSheetAction>(
      context: context,
      backgroundColor: context.appColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => PhotoSourceSheet(
        canRemove: canRemove,
        title: title,
        cameraLabel: cameraLabel,
        galleryLabel: galleryLabel,
        removePhotoLabel: removePhotoLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: DragHandle()),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: PhotoOptionCard(
                        icon: Icons.photo_camera_rounded,
                        label: cameraLabel,
                        onTap: () =>
                            Navigator.pop(context, PhotoSheetAction.camera),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PhotoOptionCard(
                        icon: Icons.photo_library_rounded,
                        label: galleryLabel,
                        onTap: () =>
                            Navigator.pop(context, PhotoSheetAction.gallery),
                      ),
                    ),
                  ],
                ),
                if (canRemove) ...[
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.pop(context, PhotoSheetAction.remove),
                    icon: const Icon(Icons.delete_outline_rounded, size: 18),
                    label: Text(removePhotoLabel!),
                    style: TextButton.styleFrom(
                      foregroundColor: colors.error,
                      minimumSize: const Size.fromHeight(44),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
