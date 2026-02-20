import 'package:flutter/material.dart';

class SearchBarWidget
    extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText:
            "Search for services (e.g. Plumbing)",
        prefixIcon:
            const Icon(Icons.search),
        filled: true,
        fillColor:
            Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}