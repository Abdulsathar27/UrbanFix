import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Date",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: availableDates.length,
            itemBuilder: (context, index) {
              final date = availableDates[index];
              final isSelected = DateUtils.isSameDay(date, selectedDate);

              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF0066FF) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getDayName(date),
                          style: TextStyle(
                            fontSize: 10,
                            color: isSelected ? Colors.white : Colors.grey[600],
                          ),
                        ),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getDayName(DateTime date) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[date.weekday % 7];
  }
}