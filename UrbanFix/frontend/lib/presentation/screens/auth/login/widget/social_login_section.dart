import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/presentation/screens/auth/login/widget/social_button.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "OR CONTINUE WITH",
                style: TextStyle(
                  color: AppColors.greyMedium,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const Expanded(child: Divider(thickness: 1)),
          ],
        ),
        kGapH20,
        Row(
          children: [
            Expanded(
              child: SocialButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.google, size: kIconSmall, color: Color(0xFFDB4437)),
                label: "Google",
              ),
            ),
            kGapW16,
            Expanded(
              child: SocialButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.apple, size: kIconSmall, color: Colors.black87),
                label: "Apple",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
