import 'package:super_fitness/features/exercises/data/models/exercises_dto.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';

extension GetExercisesMapper on ExercisesDTO {
  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id,
      exercise: exercise,
      muscle: primeMoverMuscle,
      equipment: primaryEquipment,
      difficulty: difficultyLevel,
      videoUrl: shortYoutubeDemonstrationLink,
      thumbnailUrl: _extractThumbnail(shortYoutubeDemonstrationLink),
    );
  }

  String _extractThumbnail(String? url) {
    if (url == null || url.isEmpty) return "assets/images/placeholder.png";

    final uri = Uri.tryParse(url);
    if (uri == null) return "assets/images/placeholder.png";

    String videoId = "";
    if (uri.host == 'youtu.be') {
      videoId = uri.pathSegments.first;
    } else {
      videoId = uri.queryParameters['v'] ?? "";
    }

    return videoId.isNotEmpty
        ? "https://img.youtube.com/vi/$videoId/0.jpg"
        : "assets/images/placeholder.png";
  }
}
