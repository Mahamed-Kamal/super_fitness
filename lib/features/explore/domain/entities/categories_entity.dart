class CategoriesResponseEntity {
  List<CategoriesEntity>? categories;
  CategoriesResponseEntity({required this.categories});
}

class CategoriesEntity {
  final String? idCategory;
  final String? strCategory;
  final String? strCategoryThumb;
  final String? strCategoryDescription;
  const CategoriesEntity({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });
}
