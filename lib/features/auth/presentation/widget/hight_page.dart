import 'package:flutter/material.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';

class HightPage extends StatelessWidget {
  const HightPage({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDataPicker(
            title: 'what is your hight ?',
            subtitle: 'this helps us create Your personalized plan',
            unit: 'CM',
            minValue: 100,
            maxValue: 250,
            initialValue: 170,
            onValueChanged: (f) {},
            onNext: () {
              pageController.animateToPage(
                5,
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
