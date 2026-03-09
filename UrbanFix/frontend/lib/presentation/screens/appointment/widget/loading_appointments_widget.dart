import 'package:flutter/material.dart';

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
          Text('Loading your appointments...'),
        ],
      ),
    );
  }
}