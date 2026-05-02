import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';

sealed class EditProfileIntent {
  const EditProfileIntent();
}

final class GetProfileDataIntent extends EditProfileIntent {
  const GetProfileDataIntent();
}

final class SubmitProfileIntent extends EditProfileIntent {
  final UpdateUserDataRequest request;
  const SubmitProfileIntent(this.request);
}

final class OpenEditWeightIntent extends EditProfileIntent {
  const OpenEditWeightIntent();
}

final class OpenEditGoalIntent extends EditProfileIntent {
  const OpenEditGoalIntent();
}

final class OpenEditActivityLevelIntent extends EditProfileIntent {
  const OpenEditActivityLevelIntent();
}

/// Merges weight / goal / activity from a sub-route into profile state before Save (no API).
final class ApplyProfileDraftFromSubRouteIntent extends EditProfileIntent {
  final int? weight;
  final UserGoal? goal;
  final ActivityLevel? activityLevel;

  const ApplyProfileDraftFromSubRouteIntent({
    this.weight,
    this.goal,
    this.activityLevel,
  });
}

final class SelectLocalPhotoIntent extends EditProfileIntent {
  final File file;
  const SelectLocalPhotoIntent(this.file);
}

final class UploadPhotoIntent extends EditProfileIntent {
  final File imageFile;
  const UploadPhotoIntent(this.imageFile);
}

final class PickImageFromGalleryIntent extends EditProfileIntent {
  const PickImageFromGalleryIntent();
}

final class PickImageFromCameraIntent extends EditProfileIntent {
  const PickImageFromCameraIntent();
}

sealed class EditProfileUIEvent {
  const EditProfileUIEvent();
}

final class ShowToastUIEvent extends EditProfileUIEvent {
  final String message;
  final bool isError;

  const ShowToastUIEvent({required this.message, this.isError = false});
}

final class PopScreenEvent extends EditProfileUIEvent {
  const PopScreenEvent();
}

final class NavigateToEditWeightUIEvent extends EditProfileUIEvent {
  final int initialWeight;
  const NavigateToEditWeightUIEvent(this.initialWeight);
}

final class NavigateToEditGoalUIEvent extends EditProfileUIEvent {
  final UserGoal initialGoal;
  const NavigateToEditGoalUIEvent(this.initialGoal);
}

final class NavigateToEditActivityLevelUIEvent extends EditProfileUIEvent {
  final ActivityLevel initialLevel;
  const NavigateToEditActivityLevelUIEvent(this.initialLevel);
}

final class PopWithImageSourceEvent extends EditProfileUIEvent {
  final ImageSource source;
  const PopWithImageSourceEvent(this.source);
}
