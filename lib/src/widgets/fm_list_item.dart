import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../theme/app_colors_extension.dart';

/// List row: avatar circle + title + optional subtitle + optional badge + trailing.
///
/// Pass [avatarImageUrl] for a network image (falls back to [avatarText]
/// initials while loading, or if empty/failed), [avatarText] for initials,
/// or [avatarIcon] for an icon avatar. Default trailing is a chevron_right icon.
///
/// Unlike the app-owned version this was extracted from, [cacheManager] is an
/// optional parameter instead of a hardcoded app-specific singleton — pass
/// your app's own `CacheManager` (e.g. a capped-size/TTL one) if you have
/// one; `null` falls back to `CachedNetworkImage`'s own default.
class FmListItem extends StatelessWidget {
  const FmListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.avatarText,
    this.avatarIcon,
    this.avatarImageUrl,
    this.badge,
    this.trailing,
    this.hideTrailing = false,
    this.tint,
    this.onTap,
    this.cacheManager,
  });

  final String title;
  final String? subtitle;
  final String? avatarText;
  final IconData? avatarIcon;
  final String? avatarImageUrl;
  final Widget? badge;
  final Widget? trailing;
  final bool hideTrailing;

  /// Overrides the avatar and title color (e.g. error-red for destructive rows).
  final Color? tint;
  final VoidCallback? onTap;
  final BaseCacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final avatarBg = tint?.withValues(alpha: 0.1) ?? colors.primaryContainer;
    final avatarFg = tint ?? colors.primary;

    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 54),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            _Avatar(
              text: avatarText,
              icon: avatarIcon,
              imageUrl: avatarImageUrl,
              bg: avatarBg,
              fg: avatarFg,
              cacheManager: cacheManager,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: tint ?? colors.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 1),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (badge != null) ...[const SizedBox(width: 8), badge!],
            if (!hideTrailing) ...[
              const SizedBox(width: 4),
              trailing ??
                  Icon(Icons.chevron_right, size: 18, color: colors.outline),
            ],
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    this.text,
    this.icon,
    this.imageUrl,
    required this.bg,
    required this.fg,
    this.cacheManager,
  });

  final String? text;
  final IconData? icon;
  final String? imageUrl;
  final Color bg;
  final Color fg;
  final BaseCacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    final fallback = icon != null
        ? Icon(icon, size: 20, color: fg)
        : Text(
            (text ?? '?').toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: fg,
            ),
          );

    return Container(
      width: 36,
      height: 36,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      // Network image overlays the initials/icon fallback; transparent
      // placeholder/error keep the fallback visible while loading or if the
      // URL is empty/broken.
      child: (imageUrl == null || imageUrl!.isEmpty)
          ? fallback
          : Stack(
              fit: StackFit.expand,
              children: [
                Center(child: fallback),
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

/// Generic naming alias for [FmListItem].
typedef AppListItem = FmListItem;
