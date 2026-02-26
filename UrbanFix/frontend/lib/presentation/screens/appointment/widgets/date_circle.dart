import 'package:flutter/material.dart';

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
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Text(
          day,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
