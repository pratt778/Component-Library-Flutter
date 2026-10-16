import 'package:flutter/material.dart';

class CircularActionButton extends StatelessWidget {
  const CircularActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.isLoading = false,
    this.size = 44,
    this.iconSize = 22,
    this.loadingSize = 20,
    this.backgroundColor,
  });

  final VoidCallback onPressed;
  final Widget icon;
  final bool isLoading;
  final double size;
  final double iconSize;
  final double loadingSize;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
        ),
        child: isLoading
            ? SizedBox(
                height: loadingSize,
                width: loadingSize,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : icon,
      ),
    );
  }
}
