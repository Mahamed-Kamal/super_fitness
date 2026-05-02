import 'package:equatable/equatable.dart';

class MealCategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? thumbUrl;
  final String? description;

  const MealCategoryEntity({
    required this.id,
    required this.name,
    this.thumbUrl,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, thumbUrl, description];
}
