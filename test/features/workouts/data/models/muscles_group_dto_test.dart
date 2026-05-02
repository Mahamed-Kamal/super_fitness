import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_group_dto.dart';

void main() {
  test(
    'when call toEntity with null data it should return MusclesEntity with null data',
    () {
      //arr
      MusclesGroupDto dto = MusclesGroupDto(id: null, name: null);
      //acc
      var entity = dto.toEntity();
      //ass
      expect(entity.name, isNull);
      expect(entity.name, isNull);
    },
  );
}
