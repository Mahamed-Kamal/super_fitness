import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_view_model.dart';
import 'package:super_fitness/features/explore/presentation/widgets/gym_coming_soon_dialog.dart';

class FitnessCategories extends StatelessWidget {
  const FitnessCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xff222323),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _CategoriesModel.listOfCategories.length,
        separatorBuilder: (context, index) => const VerticalDivider(
          color: Color(0xff3a3a3a),
          thickness: 1,
          width: 1,
        ),
        itemBuilder: (context, index) => SizedBox(
          width:
              MediaQuery.of(context).size.width /
              _CategoriesModel.listOfCategories.length,
          child: categoryItem(context, index),
        ),
      ),
    );
  }

  Widget categoryItem(BuildContext context, int index) => GestureDetector(
    onTap:
        _CategoriesModel.listOfCategories[index].goToCategoryScreen ??
        () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const GymComingSoonDialog(),
          );
        },
    child: Column(
      spacing: 4,
      children: [
        Expanded(
          child: Image.asset(
            _CategoriesModel.listOfCategories[index].categoryImage,
            fit: BoxFit.contain,
          ),
        ),
        Text(_CategoriesModel.listOfCategories[index].categoryTitle.tr()),
      ],
    ),
  );
}

class _CategoriesModel {
  final String categoryImage;
  final String categoryTitle;
  final VoidCallback? goToCategoryScreen;

  _CategoriesModel({
    required this.categoryImage,
    required this.categoryTitle,
    this.goToCategoryScreen,
  });

  static List<_CategoriesModel> get listOfCategories => [
    _CategoriesModel(
      categoryImage: AssetsManager.gym,
      categoryTitle: "explore.gym",
      goToCategoryScreen: () {
        getIt.get<AppSectionViewModel>().doIntent(2);
      },
    ),
    _CategoriesModel(
      categoryImage: AssetsManager.fitness,
      categoryTitle: "explore.fitness",
      goToCategoryScreen: null,
    ),
    _CategoriesModel(
      categoryImage: AssetsManager.yoga,
      categoryTitle: "explore.yoga",
      goToCategoryScreen: null,
    ),
    _CategoriesModel(
      categoryImage: AssetsManager.aerobics,
      categoryTitle: "explore.aerobics",
      goToCategoryScreen: null,
    ),
    _CategoriesModel(
      categoryImage: AssetsManager.trainer,
      categoryTitle: "explore.trainer",
      goToCategoryScreen: () {
        getIt.get<AppSectionViewModel>().doIntent(1);
      },
    ),
  ];
}
