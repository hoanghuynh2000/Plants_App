import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  const GradientIcon(
    this.icons, {
    required this.gradient,
  });

  final IconData icons;

  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Icon(icons),
    );
  }
}
