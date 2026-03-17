import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});
  final List<Map<String, dynamic>> categories = const [
    {
      'name': 'General Service',
      'icon': '⚙️',
      'description': 'General services',
      'color': AppColors.categoryGeneralService,
    },
    {
      'name': 'Construction',
      'icon': '🏗️',
      'description': 'Construction work',
      'color': AppColors.categoryConstruction,
    },
    {
      'name': 'Electrical',
      'icon': '⚡',
      'description': 'Electrical repairs',
      'color': AppColors.categoryElectrical,
    },
    {
      'name': 'Plumbing',
      'icon': '🔧',
      'description': 'Plumbing repairs',
      'color': AppColors.categoryPlumbing,
    },
    {
      'name': 'Carpentry',
      'icon': '🪛',
      'description': 'Carpentry work',
      'color': AppColors.categoryCarpentry,
    },
    {
      'name': 'Painting',
      'icon': '🎨',
      'description': 'Painting services',
      'color': AppColors.categoryPainting,
    },
    {
      'name': 'Repair & Maintenance',
      'icon': '🔨',
      'description': 'Repairs & maintenance',
      'color': AppColors.success,
    },
    {
      'name': 'Cleaning',
      'icon': '🧹',
      'description': 'Cleaning services',
      'color': AppColors.categoryCleaning,
    },
    {
      'name': 'Sales & Delivery',
      'icon': '📦',
      'description': 'Sales & delivery',
      'color': AppColors.info,
    },
    {
      'name': 'Healthcare Support',
      'icon': '🏥',
      'description': 'Healthcare support',
      'color': AppColors.categoryHealthcare,
    },
    {
      'name': 'Cooking',
      'icon': '👨‍🍳',
      'description': 'Cooking services',
      'color': AppColors.categoryCooking,
    },
    {
      'name': 'Gardening',
      'icon': '🌱',
      'description': 'Gardening services',
      'color': AppColors.success,
    },
    {
      'name': 'Other',
      'icon': '✨',
      'description': 'Other services',
      'color': AppColors.categoryOther,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.lightTextPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          AppStrings.selectService,
          style: TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Header text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.whatServiceDoYouNeed,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.chooseCategoryToViewWorkers,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.greyDark,
                      ),
                ),
              ],
            ),
          ),

          // Categories grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(
                  name: category['name'],
                  icon: category['icon'],
                  description: category['description'],
                  color: category['color'],
                  onTap: () {
                    // Save category in controller, then push job selection
                    context
                        .read<AppointmentController>()
                        .category = category['name'] as String;
                    context.pushNamed(
                      'select-job',
                      extra: category['name'] as String,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual Category Card
class CategoryCard extends StatefulWidget {
  final String name;
  final String icon;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const CategoryCard({
    required this.name,
    required this.icon,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => isPressed = true);
      },
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => isPressed = false);
      },
      child: Transform.scale(
        scale: isPressed ? 0.95 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightTextPrimary.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    widget.icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightTextPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 11,
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
  }
}