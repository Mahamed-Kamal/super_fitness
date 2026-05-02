import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/profile/domain/repo/profile_repo.dart';

@injectable
class UploadProfilePhotoUseCase {
  final ProfileRepo _profileRepo;

  UploadProfilePhotoUseCase(this._profileRepo);

  Future<Result<String>> call({required MultipartFile photo}) =>
      _profileRepo.uploadProfilePhoto(photo: photo);
}
