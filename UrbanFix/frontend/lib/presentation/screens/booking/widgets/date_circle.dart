import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class DateCircle extends StatelessWidget {
  const DateCircle({
    super.key,
    required this.day,
    required this.onTap,
    this.selected = false,
  });
  final String day;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        height: kHeight40,
        width: kWidth40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.transparent,
          shape: BoxShape.circle,
        ),
        child: Text(
          day,
          style: TextStyle(
            color: selected ? AppColors.white : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
