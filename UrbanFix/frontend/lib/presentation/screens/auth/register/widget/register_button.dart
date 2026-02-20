import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RegisterButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
       onPressed: isLoading
            ? null
            : () {
                onPressed();
                context.goNamed('login');
              },
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.white,
                  size: 30,
                ),
              )
            : const Text(
              AppStrings.createAccount,
            style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),),
      ),
    );
  }
}
