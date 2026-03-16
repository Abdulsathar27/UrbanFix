import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_strings.dart';

class LoadingAppointmentsWidget extends StatelessWidget {
  const LoadingAppointmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(AppStrings.loadingAppointments),
        ],
      ),
    );
  }
}
