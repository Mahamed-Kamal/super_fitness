import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DifficultyLevelsList extends StatelessWidget {
  const DifficultyLevelsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 30, top: 7, bottom: 7),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: index == 0 ? Colors.red : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          'Beginner',
          style: GoogleFonts.balooThambi2(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
