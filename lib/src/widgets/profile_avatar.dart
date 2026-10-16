import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../theme/app_colors_extension.dart';

/// Round avatar for a person — a customer or the signed-in operator.
///
/// Shows [imageUrl] when it resolves, falling back to their initials (up to 2
/// chars) on a primary-container circle while loading, or if the URL is
/// empty/broken. The initials sit *behind* the image rather than in
/// `placeholder`, so a broken URL degrades to them with no second layout pass.
///
/// Unlike the app-owned version this was extracted from, [cacheManager] is
/// optional instead of a hardcoded app-specific singleton — pass your app's
/// own `CacheManager` if you have one; `null` falls back to
/// `CachedNetworkImage`'s own default.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.colors,
    required this.name,
    this.imageUrl,
    this.size = 48,
    this.cacheManager,
  });

  final AppColorsExtension colors;
  final String name;
  final String? imageUrl;
  final double size;
  final BaseCacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    final initials = Text(
      name
          .split(' ')
          .map((e) => e.isNotEmpty ? e[0] : '')
          .take(2)
          .join()
          .toUpperCase(),
      style: TextStyle(
        // Initials scale with the circle so a 64 dp avatar does not read as a
        // large ring around small text.
        fontSize: size * 0.375,
        fontWeight: FontWeight.w600,
        color: colors.primary,
      ),
    );

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: (imageUrl == null || imageUrl!.isEmpty)
          ? initials
          : Stack(
              fit: StackFit.expand,
              children: [
                Center(child: initials),
                CachedNetworkImage(
                  imageUrl: imageUrl!,
                  cacheManager: cacheManager,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => const SizedBox.shrink(),
                  errorWidget: (_, _, _) => const SizedBox.shrink(),
                ),
              ],
            ),
    );
  }
}
