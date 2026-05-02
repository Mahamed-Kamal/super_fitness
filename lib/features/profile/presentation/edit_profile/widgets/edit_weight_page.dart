import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/core/widgets/super_fitness_app_bar.dart';
import 'package:super_fitness/features/auth/presentation/widget/custom_data_packer.dart';

class EditWeightPage extends StatefulWidget {
  final int initialWeight;

  const EditWeightPage({super.key, required this.initialWeight});

  @override
  State<EditWeightPage> createState() => _EditWeightPageState();
}

class _EditWeightPageState extends State<EditWeightPage> {
  late int _weight;

  @override
  void initState() {
    super.initState();
    _weight = widget.initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SuperFitnessAppBar(logo: AssetsManager.appLogoSvg),
      body: ScreenBackdrop(
        image: AssetsManager.homeBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomDataPicker(
              title: "what_is_your_weight".tr(),
              subtitle: "personalized_plan_subtitle".tr(),
              unit: 'kg'.tr(),
              minValue: 40,
              maxValue: 200,
              initialValue: _weight,
              onValueChanged: (value) => _weight = value,
              onNext: () => Navigator.pop(context, _weight),
            ),
          ),
        ),
      ),
    );
  }
}
