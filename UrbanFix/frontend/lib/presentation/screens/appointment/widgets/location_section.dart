import 'package:flutter/material.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Service Location",
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
          child: Row(
            children: const [
              Icon(Icons.location_on, color: Colors.blue),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text("Home Address",
                        style: TextStyle(
                            fontWeight:
                                FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(
                      "123 Lavender Lane, Apt 4B,\nSilicon Valley, CA 94025",
                      style: TextStyle(
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                "Edit",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        )
      ],
    );
  }
}