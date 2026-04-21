import 'package:flutter/material.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xff222323),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
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
          child: categoryItem(index),
        ),
      ),
    );
  }

  Widget categoryItem(int index) => Column(
    spacing: 4,
    children: [
      Image.asset(_CategoriesModel.listOfCategories[index].categoryImage),
      Text(_CategoriesModel.listOfCategories[index].categoryTitle),
    ],
  );
}

class _CategoriesModel {
  final String categoryImage;
  final String categoryTitle;
  final String? goToCategoryScreen;

  _CategoriesModel({
    required this.categoryImage,
    required this.categoryTitle,
    this.goToCategoryScreen,
  });

  static List<_CategoriesModel> get listOfCategories => [
    _CategoriesModel(
      categoryImage: AssetsManager.gym,
      categoryTitle: "Gym",
      goToCategoryScreen: null,
    ),
    _CategoriesModel(
      categoryImage: AssetsManager.fitness,
      categoryTitle: "Fitness",
      goToCategoryScreen: null,
    ),
    _CategoriesModel(
      categoryImage: AssetsManager.yoga,
      categoryTitle: "Yoga",
      goToCategoryScreen: null,
    ),
    _CategoriesModel(
      categoryImage: AssetsManager.aerobics,
      categoryTitle: "Aerobics",
      goToCategoryScreen: null,
    ),
    _CategoriesModel(
      categoryImage: AssetsManager.trainer,
      categoryTitle: "Trainer",
      goToCategoryScreen: null,
    ),
  ];
}
