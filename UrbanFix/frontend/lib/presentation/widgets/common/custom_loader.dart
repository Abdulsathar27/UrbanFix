import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final String? message;
  final double size;
  final bool withOverlay;

  const CustomLoader({
    super.key,
    this.message,
    this.size = 40,
    this.withOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    final loader = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: size,
          width: size,
          child: const CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 12),
          Text(
            message!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium,
          ),
        ],
      ],
    );

    if (!withOverlay) {
      return Center(child: loader);
    }

    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.4),
        ),
        Center(child: loader),
      ],
    );
  }
}
