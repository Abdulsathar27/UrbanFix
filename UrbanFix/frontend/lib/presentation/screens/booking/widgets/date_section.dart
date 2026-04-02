import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'package:frontend/core/constants/appsize_constants.dart';
import 'package:frontend/presentation/screens/booking/widgets/section_header.dart';

class DateSection extends StatelessWidget {
  const DateSection({
    super.key,
    required this.availableDates,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final List<DateTime> availableDates;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  static const _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          icon: Icons.calendar_month_rounded,
          label: AppStrings.selectDate,
        ),
        kGapH12,
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            itemCount: availableDates.length,
            separatorBuilder: (_, __) => kGapW8,
            itemBuilder: (context, index) {
              final date = availableDates[index];
              final isSelected = DateUtils.isSameDay(date, selectedDate);
              final isToday = DateUtils.isSameDay(date, DateTime.now());

              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 52,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.28),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _days[date.weekday % 7],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppColors.white.withValues(alpha: 0.8)
                              : AppColors.greyMedium,
                        ),
                      ),
                      kGapH4,
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? AppColors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 3),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: kWidth4,
                        height: kHeight4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isToday
                              ? (isSelected ? AppColors.white : AppColors.primary)
                              : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${_months[selectedDate.month - 1]} ${selectedDate.year}',
          style: const TextStyle(
            fontSize: kFontSmall,
            color: AppColors.greyMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
