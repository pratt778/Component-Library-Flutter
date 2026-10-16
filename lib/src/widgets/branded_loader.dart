import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_colors_extension.dart';

/// A spinning ring SVG with a static logo centered inside it — the branded
/// counterpart to a plain [CircularProgressIndicator].
///
/// Unlike the app-owned version this was extracted from, [centerAsset] /
/// [ringAsset] are required SVG asset paths instead of hardcoded brand
/// assets — pass your own app's logo/ring SVGs. A plain asset path like
/// `'assets/images/ring.svg'` resolves against the *app's* asset bundle (as
/// declared in the app's own `pubspec.yaml` `assets:` section), not the
/// package's, so no `package:` qualifier is needed.
///
/// The rotation is self-driven by an internal [AnimationController] — no
/// external controller needed from the caller.
class BrandedLoader extends StatefulWidget {
  const BrandedLoader({
    super.key,
    required this.centerAsset,
    required this.ringAsset,
    this.size = 50,
    this.color,
  });

  final String centerAsset;
  final String ringAsset;
  final double size;

  /// Tint for the rotating ring SVG. Defaults to `context.appColors.primary`;
  /// override with a static brand colour on a screen — like splash — that
  /// deliberately ignores the light/dark theme.
  final Color? color;

  @override
  State<BrandedLoader> createState() => _BrandedLoaderState();
}

class _BrandedLoaderState extends State<BrandedLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ringColor = widget.color ?? context.appColors.primary;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ~70% of the ring's diameter — small enough that the spinning
          // stroke stays visible around it rather than getting covered.
          SizedBox(
            width: widget.size * 0.7,
            height: widget.size * 0.7,
            child: SvgPicture.asset(widget.centerAsset),
          ),
          RotationTransition(
            turns: _controller,
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: SvgPicture.asset(
                widget.ringAsset,
                colorFilter: ColorFilter.mode(ringColor, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
