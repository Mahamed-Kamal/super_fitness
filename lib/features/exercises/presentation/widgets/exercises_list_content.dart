import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/custom_image_view.dart';
import 'package:super_fitness/features/exercises/domain/entity/exercises_entity.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExercisesListContent extends StatelessWidget {
  const ExercisesListContent({
    super.key,
    required this.index,
    required this.exercise,
    required this.primeEquipment,
    required this.thumbnail,
    required this.videoUrl,
    required this.exercises,
  });
  final int index;
  final String exercise;
  final String primeEquipment;
  final String thumbnail;
  final String videoUrl;
  final List<ExerciseEntity> exercises;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appTheme.neutral,
        borderRadius: index == 0
            ? BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              )
            : exercises.length - 1 == index
            ? BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              )
            : BorderRadius.circular(0),
        border: Border(
          bottom: BorderSide(
            color: context.appTheme.borderMuted.withAlpha(50),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomImageView(
              imagePath: thumbnail,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
              placeHolder: AssetsManager.placeholder,
            ),
          ),

          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise,
                  style: context.appTheme.medium16.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "3 Groups * 15 Times",
                  style: context.appTheme.regular14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),

                Text(
                  primeEquipment,
                  style: context.appTheme.regular14.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepOrange,
            ),
            child: IconButton(
              onPressed: () => _showVideoDialog(context, videoUrl),
              icon: Icon(
                Icons.play_arrow_rounded,
                color: context.appTheme.neutral,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showVideoDialog(BuildContext context, String? videoUrl) {
    if (videoUrl == null || videoUrl.isEmpty) {
      _showDialog(context);
      return;
    }

    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    if (videoId != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.black,
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.deepOrange,
            ),
          ),
        ),
      );
    }
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        title: Text(
          "notice".tr(),
          style: TextStyle(color: context.appTheme.textMuted),
        ),
        content: Text(
          "no_video".tr(),
          style: TextStyle(color: context.appTheme.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "ok".tr(),
              style: TextStyle(color: context.appTheme.blackElevated),
            ),
          ),
        ],
      ),
    );
  }
}
