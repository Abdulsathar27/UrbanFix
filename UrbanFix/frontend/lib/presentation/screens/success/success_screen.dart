import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/presentation/screens/success/widget/decorative_circles.dart';
import 'package:frontend/presentation/screens/success/widget/info_chip.dart';
import 'package:frontend/presentation/screens/success/widget/success_badge.dart';
import 'package:go_router/go_router.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          
          const DecorativeCircles(),

          
          Column(
            children: [
              Expanded(
                flex: 5,
                child: SafeArea(
                  child: Center(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.elasticOut,
                      builder: (_, value, child) => Transform.scale(
                        scale: value,
                        child: child,
                      ),
                      child: const SuccessBadge(),
                    ),
                  ),
                ),
              ),

             
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(36),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(28, 36, 28, 0),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       
                        const Text(
                          'Booking Confirmed!',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightTextPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Your appointment has been scheduled.\nWe\'ll notify you before the visit.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.greyMedium,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 28),

                      
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            InfoChip(
                              icon: Icons.check_circle_outline_rounded,
                              label: 'Pending',
                              color: AppColors.warning,
                            ),
                            SizedBox(width: 12),
                            InfoChip(
                              icon: Icons.notifications_active_outlined,
                              label: 'You\'ll be notified',
                              color: AppColors.info,
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),

                       
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () => context.goNamed('home'),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.home_rounded, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Back to Home',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                      
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: const BorderSide(
                                  color: AppColors.primary, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () =>
                                context.goNamed('my_appointments'),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today_rounded, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  AppStrings.myAppointments,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

