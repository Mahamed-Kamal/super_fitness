import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';

class SpecialMusclesResponseEntity {
  final List<MusclesEntity> muscles;
  final MusclesGroupEntity musclesGroup;

  SpecialMusclesResponseEntity({
    required this.muscles,
    required this.musclesGroup,
  });
}
