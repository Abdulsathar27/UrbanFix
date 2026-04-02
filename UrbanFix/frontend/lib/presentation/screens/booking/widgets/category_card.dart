import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final String icon;
  final String description;
  final Color color;

  const CategoryCard({
    super.key,
    required this.name,
    required this.icon,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentController>(
      builder: (context, controller, _) {
        return Material(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: kBorderRadiusLarge,
          child: InkWell(
            borderRadius: kBorderRadiusLarge,
            onTap: () {
              controller.category = name;
              context.pushNamed('select-job', extra: name);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kBorderRadiusLarge,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.08),
                    blurRadius: kSpaceSmall,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: kWidth56,
                    height: kHeight56,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: kBorderRadiusMedium,
                    ),
                    child: Center(
                      child: Text(
                        icon,
                        style: const TextStyle(fontSize: kFontDisplay),
                      ),
                    ),
                  ),
                  kGapH12,
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: kFontBase,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  kGapH8,
                  Padding(
                    padding: kPaddingHSmall,
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: kFontXSmall,
                        color: AppColors.greyMedium,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
