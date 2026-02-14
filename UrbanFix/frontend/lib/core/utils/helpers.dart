import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class Helpers {
  // ===============================
  // Snackbar
  // ===============================
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

  // ===============================
  // Error Snackbar
  // ===============================
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

  // ===============================
  // Success Snackbar
  // ===============================
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

  // ===============================
  // Loading Dialog
  // ===============================
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

  // ===============================
  // Confirmation Dialog
  // ===============================
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
}
