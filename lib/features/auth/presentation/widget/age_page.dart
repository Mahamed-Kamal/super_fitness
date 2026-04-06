import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  int _age = 24;

  @override
  void initState() {
    super.initState();
    final savedAge = context.read<RegisterViewModel>().state.formData.age;
    if (savedAge != 0) _age = savedAge;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDataPicker(
            title: 'how_old_are_you'.tr(),
            subtitle: 'personalized_plan_subtitle'.tr(),
            unit: 'year'.tr(),
            minValue: 10,
            maxValue: 99,
            initialValue: _age,
            onValueChanged: (value) => setState(() => _age = value),
            onNext: () => context.read<RegisterViewModel>().doIntent(
              SwitchViewToSelectAge(age: _age),
            ),
          ),
        ],
      ),
    );
  }
}
