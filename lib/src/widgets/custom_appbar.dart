import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool hideTitle;
  final Widget? trailing;
  final Widget? centerChild;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.hideTitle = false,
    this.trailing,
    this.centerChild,
    this.onBackPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final fg = foregroundColor ?? Colors.white;

    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: backgroundColor ?? colors.primary,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBackButton)
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: fg,
                    size: 22,
                  ),
                  onPressed: onBackPressed ?? () => Navigator.maybePop(context),
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                )
              else
                const SizedBox(width: 38),
              if (!hideTitle)
                Expanded(
                  child:
                      centerChild ??
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: fg,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          letterSpacing: -0.17,
                        ),
                      ),
                ),
              trailing ?? const SizedBox(width: 38),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);
}
