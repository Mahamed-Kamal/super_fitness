import 'package:super_fitness/features/explore/domain/entities/categories_entity.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';

sealed class ExploreSection {
  int index;
  ExploreSection(this.index);
}

class MusclesRandomSection extends ExploreSection {
  List<MusclesEntity> muscles;
  MusclesRandomSection(this.muscles, super.index);
}

class MusclesGroupSection extends ExploreSection {
  final List<MusclesGroupEntity> musclesGroup;

  MusclesGroupSection(this.musclesGroup, super.index);
}

class CategoriesSection extends ExploreSection {
  final List<CategoriesEntity> categories;

  CategoriesSection(this.categories, super.index);
}
