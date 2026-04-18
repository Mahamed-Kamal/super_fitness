import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int _weight = 70;

  @override
  void initState() {
    super.initState();
    final savedWeight = context.read<RegisterViewModel>().state.formData.weight;
    if (savedWeight != 0) _weight = savedWeight;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDataPicker(
            title: "what_is_your_weight".tr(),
            subtitle: "personalized_plan_subtitle".tr(),
            unit: 'kg'.tr(),
            minValue: 40,
            maxValue: 200,
            initialValue: _weight,
            onValueChanged: (value) => setState(() => _weight = value),
            onNext: () => context.read<RegisterViewModel>().doIntent(
              SwitchViewToSelectHeight(weight: _weight),
            ),
          ),
        ],
      ),
    );
  }
}
