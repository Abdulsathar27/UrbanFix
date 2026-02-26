// NEW CODE - Design 2: Neomorphic Premium
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchBarWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [Colors.grey.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            // Outer shadow for neomorphic effect
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 15,
              offset: const Offset(5, 5),
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 15,
              offset: const Offset(-5, -5),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "What service are you looking for?",
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontStyle: FontStyle.italic,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blue.shade700,
              size: 24,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.grey.shade300,
                ),
                IconButton(
                  onPressed: () {
                    // Add filter functionality
                  },
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}