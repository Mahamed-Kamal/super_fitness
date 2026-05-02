import 'package:flutter/material.dart';

class PlaceholderHero extends StatelessWidget {
  const PlaceholderHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A1A10), Color(0xFF1A1A1A)],
        ),
      ),
      child: const Icon(Icons.restaurant, size: 64, color: Color(0xFF333333)),
    );
  }
}
