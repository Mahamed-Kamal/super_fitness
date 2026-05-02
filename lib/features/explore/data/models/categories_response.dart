import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/explore/data/models/categories_dto.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "categories")
  final List<Categories>? categories;

  CategoriesResponse({this.categories});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesResponseToJson(this);
  }
}
