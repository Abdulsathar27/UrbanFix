import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class DecorativeCircles extends StatelessWidget {
  const DecorativeCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -40,
          right: -40,
          child: _circle(160, alpha: 0.08),
        ),
        Positioned(
          top: 80,
          left: -60,
          child: _circle(200, alpha: 0.06),
        ),
        Positioned(
          top: 200,
          right: 20,
          child: _circle(60, alpha: 0.1),
        ),
        Positioned(
          top: 140,
          left: 40,
          child: _circle(30, alpha: 0.12),
        ),
      ],
    );
  }

  Widget _circle(double size, {required double alpha}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withValues(alpha: alpha),
      ),
    );
  }
}
