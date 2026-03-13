import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});
  final List<Map<String, dynamic>> categories = const [
    {
      'name': 'General Service',
      'icon': '⚙️',
      'description': 'General services',
      'color': Color(0xFF6C757D),
    },
    {
      'name': 'Construction',
      'icon': '🏗️',
      'description': 'Construction work',
      'color': Color(0xFFFFC107),
    },
    {
      'name': 'Electrical',
      'icon': '⚡',
      'description': 'Electrical repairs',
      'color': Color(0xFFFFB800),
    },
    {
      'name': 'Plumbing',
      'icon': '🔧',
      'description': 'Plumbing repairs',
      'color': Color(0xFF0066FF),
    },
    {
      'name': 'Carpentry',
      'icon': '🪛',
      'description': 'Carpentry work',
      'color': Color(0xFF8B4513),
    },
    {
      'name': 'Painting',
      'icon': '🎨',
      'description': 'Painting services',
      'color': Color(0xFFEE82EE),
    },
    {
      'name': 'Repair & Maintenance',
      'icon': '🔨',
      'description': 'Repairs & maintenance',
      'color': Color(0xFF4CAF50),
    },
    {
      'name': 'Cleaning',
      'icon': '🧹',
      'description': 'Cleaning services',
      'color': Color(0xFF00CC88),
    },
    {
      'name': 'Sales & Delivery',
      'icon': '📦',
      'description': 'Sales & delivery',
      'color': Color(0xFF2196F3),
    },
    {
      'name': 'Healthcare Support',
      'icon': '🏥',
      'description': 'Healthcare support',
      'color': Color(0xFFE91E63),
    },
    {
      'name': 'Cooking',
      'icon': '👨‍🍳',
      'description': 'Cooking services',
      'color': Color(0xFFFF6F00),
    },
    {
      'name': 'Gardening',
      'icon': '🌱',
      'description': 'Gardening services',
      'color': Color(0xFF4CAF50),
    },
    {
      'name': 'Other',
      'icon': '✨',
      'description': 'Other services',
      'color': Color(0xFF9C27B0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Select Service',
          style: TextStyle(
            color: Colors.black,
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
                  'What service do you need?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a category to view available workers',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
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
                    context.goNamed(
                      'bookings',
                      extra: {
                        'category': category['name'],
                      },
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
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
                  color: widget.color.withOpacity(0.15),
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
                  color: Colors.black,
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
                    color: Colors.grey,
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