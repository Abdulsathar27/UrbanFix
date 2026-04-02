import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class Helpers {
  
  static void showSnackBar(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  
  static void showError(
    BuildContext context,
    String message,
  ) {
    showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.error,
    );
  }

  
  static void showSuccess(
    BuildContext context,
    String message,
  ) {
    showSnackBar(
      context,
      message: message,
      backgroundColor: AppColors.success,
    );
  }

  
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  
  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(cancelText),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }

   static void showDetails(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Details for $title'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1B3A6B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
