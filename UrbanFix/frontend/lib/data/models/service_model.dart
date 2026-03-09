import 'package:flutter/material.dart';

class Service {
  final String name;
  final IconData icon;
  final Color color;
  final double price;
  final String description;

  Service({
    required this.name,
    required this.icon,
    required this.color,
    required this.price,
    required this.description,
  });
}