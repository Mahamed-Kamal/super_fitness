import 'package:flutter/material.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';

class AgePage extends StatelessWidget {
  const AgePage({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDataPicker(
            title: 'How Old Are you ?',
            subtitle: 'this helps us create Your personalized plan',
            unit: 'year',
            minValue: 10,
            maxValue: 99,
            initialValue: 16,
            onValueChanged: (f) {},
            onNext: () {
              pageController.animateToPage(
                3,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
          ),
        ],
      ),
    );
  }
}
