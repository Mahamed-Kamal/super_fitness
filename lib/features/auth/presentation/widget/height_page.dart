import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({super.key});

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  int _height = 180;

  @override
  void initState() {
    super.initState();
    final savedHeight = context.read<RegisterViewModel>().state.formData.height;
    if (savedHeight != 0) _height = savedHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDataPicker(
            title: "what_is_your_height".tr(),
            subtitle: "personalized_plan_subtitle".tr(),
            unit: 'cm'.tr(),
            minValue: 100,
            maxValue: 250,
            initialValue: _height,
            onValueChanged: (value) => setState(() => _height = value),
            onNext: () => context.read<RegisterViewModel>().doIntent(
              SwitchViewToSelectGoal(height: _height),
            ),
          ),
        ],
      ),
    );
  }
}
