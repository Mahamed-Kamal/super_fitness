import 'package:flutter/material.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';

class WeightPage extends StatelessWidget {
  const WeightPage({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDataPicker(
            title: 'what is your weight ?',
            subtitle: 'this helps us create Your personalized plan',
            unit: 'KG',
            minValue: 40,
            maxValue: 200,
            initialValue: 70,
            onValueChanged: (f) {},
            onNext: () {
              pageController.animateToPage(
                4,
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
