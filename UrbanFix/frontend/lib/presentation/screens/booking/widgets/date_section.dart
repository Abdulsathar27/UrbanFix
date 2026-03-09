import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/booking/widgets/date_circle.dart';

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

  static const List<String> _monthNames = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Date",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                  "${_monthNames[selectedDate.month - 1]} ${selectedDate.year}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: availableDates.map((DateTime date) {
                  return DateCircle(
                    day: date.day.toString(),
                    selected: DateUtils.isSameDay(date, selectedDate),
                    onTap: () => onDateSelected(date),
                  );
                }).toList(),
              )
            ],
          ),
        )
      ],
    );
  }
}

