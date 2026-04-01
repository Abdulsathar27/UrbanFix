import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/presentation/screens/booking/widgets/category_card.dart';
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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          AppStrings.selectService,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
