import 'package:flutter/material.dart';

/// =============================
/// String Extensions
/// =============================
extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  bool get isValidEmail {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$",
    );
    return emailRegex.hasMatch(this);
  }

  bool get isStrongPassword {
    return length >= 6;
  }
}

/// =============================
/// BuildContext Extensions
/// =============================
extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}

/// =============================
/// DateTime Extensions
/// =============================
extension DateExtensions on DateTime {
  String get formattedDate {
    return "${day.toString().padLeft(2, '0')}/"
        "${month.toString().padLeft(2, '0')}/"
        "$year";
  }

  String get formattedTime {
    final hourFormatted = hour > 12 ? hour - 12 : hour;
    final period = hour >= 12 ? "PM" : "AM";
    return "${hourFormatted.toString().padLeft(2, '0')}:"
        "${minute.toString().padLeft(2, '0')} $period";
  }
}
