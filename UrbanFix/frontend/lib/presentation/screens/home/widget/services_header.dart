import 'package:flutter/material.dart';
import 'package:frontend/core/constants/appsize_constants.dart';

class ServicesHeader extends StatelessWidget {
  final String title;

  const ServicesHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPaddingSymMedium,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: kFontXLarge,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
