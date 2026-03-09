import 'package:flutter/material.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchBarWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Search services...",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    context.read<UserController>().notifyListeners();
                  },
                )
              : null,
        ),
        onChanged: (value) {
          context.read<UserController>().notifyListeners();
        },
      ),
    );
  }
}