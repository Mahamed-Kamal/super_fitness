import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/explore/domain/entities/special_muscles_response_entity.dart';
import 'package:super_fitness/features/explore/domain/repo/explore_repo.dart';

@injectable
class GetSpecificMusclesGroup {
  final ExploreRepo _exploreRepo;
  GetSpecificMusclesGroup(this._exploreRepo);
  Future<Result<SpecialMusclesResponseEntity>> call({required String id}) =>
      _exploreRepo.getSpecificMusclesGroup(id: id);
}
