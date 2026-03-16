import 'package:flutter/material.dart';
import '../tokens.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color backgroundColor;
  final double size;

  const CircleButton({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor = AppColors.accent,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: backgroundColor,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(child: child),
        ),
      ),
    );
  }
}
