import 'package:json_annotation/json_annotation.dart';
part 'categories_dto.g.dart';

@JsonSerializable()
class Categories {
  @JsonKey(name: "idCategory")
  final String? idCategory;
  @JsonKey(name: "strCategory")
  final String? strCategory;
  @JsonKey(name: "strCategoryThumb")
  final String? strCategoryThumb;
  @JsonKey(name: "strCategoryDescription")
  final String? strCategoryDescription;

  Categories({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return _$CategoriesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesToJson(this);
  }
}
