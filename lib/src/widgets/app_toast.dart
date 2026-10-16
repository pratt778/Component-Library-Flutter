import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

/// Top-anchored toast — the counterpart to a bottom [SnackBar], which Flutter
/// only ever anchors at the bottom.
class AppToast {
  AppToast._();

  /// The toast currently on screen, if any. A fresh toast replaces it so
  /// they never stack — mirrors `ScaffoldMessenger.hideCurrentSnackBar`.
  static OverlayEntry? _current;

  static void showTop(
    OverlayState overlay, {
    required String message,
    bool isError = false,
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (_current?.mounted ?? false) _current!.remove();
    _current = null;

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _AppToastView(
        message: message,
        isError: isError,
        icon: icon,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        duration: duration,
        onDismiss: () {
          if (_current == entry) _current = null;
          if (entry.mounted) entry.remove();
        },
      ),
    );
    _current = entry;
    overlay.insert(entry);
  }
}

/// The visual + animation for [AppToast]. Slides + fades in from the top
/// edge, holds for `duration`, then reverses out; tapping dismisses early.
class _AppToastView extends StatefulWidget {
  const _AppToastView({
    required this.message,
    required this.isError,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    required this.duration,
    required this.onDismiss,
  });

  final String message;
  final bool isError;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Duration duration;
  final VoidCallback onDismiss;

  @override
  State<_AppToastView> createState() => _AppToastViewState();
}

class _AppToastViewState extends State<_AppToastView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )..forward();
    _timer = Timer(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    _timer?.cancel();
    if (!mounted) return;
    await _controller.reverse();
    if (!mounted) return;
    widget.onDismiss();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final background =
        widget.backgroundColor ??
        (widget.isError ? colors.error : colors.primary);
    final foreground = widget.foregroundColor ?? colors.onPrimary;

    return Positioned(
      top: 50,
      left: 0,
      right: 5,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, -0.4),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeOut),
                ),
            child: FadeTransition(
              opacity: _controller,
              child: Material(
                color: background,
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: _dismiss,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, size: 20, color: foreground),
                          const SizedBox(width: 10),
                        ],
                        Text(
                          widget.message,
                          style: TextStyle(color: foreground),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
