import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_fitness/core/extensions/context_spacing_extension.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/core/widgets/show_toast.dart';
import 'package:super_fitness/core/widgets/super_fitness_app_bar.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';
import 'package:super_fitness/features/auth/data/mappers/activity_level_mapper.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/profile/presentation/edit_profile/view_model/edit_profile_intent.dart';
import 'package:super_fitness/features/profile/presentation/edit_profile/view_model/edit_profile_view_model.dart';
import 'package:super_fitness/features/profile/presentation/edit_profile/views/edit_profile_selection_pages.dart';
import 'package:super_fitness/features/profile/presentation/edit_profile/widgets/edit_profile_image_source_tile.dart';
import 'package:super_fitness/features/profile/presentation/edit_profile/widgets/edit_profile_photo_section.dart';
import 'package:super_fitness/features/profile/presentation/edit_profile/widgets/edit_profile_tap_to_edit_field.dart';
import 'package:super_fitness/features/profile/presentation/edit_profile/widgets/edit_weight_page.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _weightDisplayController = TextEditingController();
  final _goalDisplayController = TextEditingController();
  final _activityDisplayController = TextEditingController();
  final _imagePicker = ImagePicker();

  StreamSubscription<EditProfileUIEvent>? _uiEventSubscription;
  bool _nameFieldsSeeded = false;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<EditProfileViewModel>();
    viewModel.doIntent(const GetProfileDataIntent());
    _uiEventSubscription = viewModel.uiEvents.listen(_handleUIEvent);
  }

  @override
  void dispose() {
    _uiEventSubscription?.cancel();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _weightDisplayController.dispose();
    _goalDisplayController.dispose();
    _activityDisplayController.dispose();
    super.dispose();
  }

  void _handleUIEvent(EditProfileUIEvent event) {
    if (!mounted) return;
    switch (event) {
      case ShowToastUIEvent():
        Toast.showToast(context, event.message, isError: event.isError);
      case PopScreenEvent():
        Navigator.pop(context);
      case PopWithImageSourceEvent(:final source):
        Navigator.of(context).pop(source);
      case NavigateToEditWeightUIEvent(:final initialWeight):
        unawaited(_pushWeightAndApply(initialWeight));
      case NavigateToEditGoalUIEvent(:final initialGoal):
        unawaited(_pushGoalAndApply(initialGoal));
      case NavigateToEditActivityLevelUIEvent(:final initialLevel):
        unawaited(_pushLevelAndApply(initialLevel));
    }
  }

  Future<void> _pushWeightAndApply(int initialWeight) async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => EditWeightPage(initialWeight: initialWeight),
      ),
    );
    if (!mounted || result == null) return;
    context.read<EditProfileViewModel>().doIntent(
      ApplyProfileDraftFromSubRouteIntent(weight: result),
    );
  }

  Future<void> _pushGoalAndApply(UserGoal initialGoal) async {
    final result = await Navigator.push<UserGoal>(
      context,
      MaterialPageRoute(
        builder: (_) => EditGoalSelectionPage(initialGoal: initialGoal),
      ),
    );
    if (!mounted || result == null) return;
    context.read<EditProfileViewModel>().doIntent(
      ApplyProfileDraftFromSubRouteIntent(goal: result),
    );
  }

  Future<void> _pushLevelAndApply(ActivityLevel initialLevel) async {
    final result = await Navigator.push<ActivityLevel>(
      context,
      MaterialPageRoute(
        builder: (_) => EditLevelSelectionPage(initialLevel: initialLevel),
      ),
    );
    if (!mounted || result == null) return;
    context.read<EditProfileViewModel>().doIntent(
      ApplyProfileDraftFromSubRouteIntent(activityLevel: result),
    );
  }

  void _syncFormFields(EditProfileState state) {
    final u = state.currentUser;
    if (state.getProfileDataState.isLoaded && !_nameFieldsSeeded) {
      _firstNameController.text = u.firstName;
      _lastNameController.text = u.lastName;
      _emailController.text = u.email;
      _nameFieldsSeeded = true;
    }
    final hasUserSnapshot =
        state.getProfileDataState.isLoaded ||
        state.getProfileDataState.data != null;
    if (hasUserSnapshot) {
      _weightDisplayController.text = "${u.weight} ${"kg".tr()}";
      _goalDisplayController.text = _goalLabel(u.goal);
      _activityDisplayController.text = _activityLevelLabel(u.activityLevel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileViewModel, EditProfileState>(
      listenWhen: (previous, current) {
        final becameLoaded =
            !previous.getProfileDataState.isLoaded &&
            current.getProfileDataState.isLoaded;
        if (becameLoaded) return true;
        final p = previous.currentUser;
        final c = current.currentUser;
        final tapChanged =
            p.weight != c.weight ||
            p.goal != c.goal ||
            p.activityLevel != c.activityLevel;
        return tapChanged;
      },
      listener: (_, state) => _syncFormFields(state),
      builder: (context, state) {
        final isLoading =
            state.getProfileDataState.isLoading ||
            state.editProfileState.isLoading;
        final hasUser =
            state.getProfileDataState.isLoaded ||
            state.getProfileDataState.data != null;
        final initialProfileLoading =
            state.getProfileDataState.isLoading &&
            state.getProfileDataState.data == null;

        return Scaffold(
          appBar: SuperFitnessAppBar(showBack: true, title: "Edit Profile"),
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          body: ScreenBackdrop(
            image: AssetsManager.homeBackground,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EditProfilePhotoSection(
                      localImage: state.localImage,
                      profilePictureUrl: state.currentUser.profilePicture,
                      isUploadingPhoto: state.uploadPhotoState.isLoading,
                      isInitialProfileLoading: initialProfileLoading,
                      onEditTap: _pickImageAndUpload,
                    ),
                    context.h(16),
                    ValueListenableBuilder(
                      valueListenable: _firstNameController,
                      builder: (_, _, _) => Text(
                        "${_firstNameController.text} ${_lastNameController.text}"
                            .trim(),
                        textAlign: TextAlign.center,
                        style: context.appTheme.semiBold24,
                      ),
                    ),
                    context.h(20),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        hintText: "first_name".tr(),
                        prefixIcon: Icon(CupertinoIcons.person),
                      ),
                    ),
                    context.h(10),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        hintText: "last_name".tr(),
                        prefixIcon: Icon(CupertinoIcons.person),
                      ),
                    ),
                    context.h(10),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "email".tr(),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    context.h(20),
                    EditProfileTapToEditField(
                      prefixTitle: "profile.your_weight".tr(),
                      controller: _weightDisplayController,
                      enabled: hasUser,
                      onClickTap: () => context
                          .read<EditProfileViewModel>()
                          .doIntent(const OpenEditWeightIntent()),
                    ),
                    const SizedBox(height: 12),
                    EditProfileTapToEditField(
                      prefixTitle: "profile.your_goal".tr(),
                      controller: _goalDisplayController,
                      enabled: hasUser,
                      onClickTap: () => context
                          .read<EditProfileViewModel>()
                          .doIntent(const OpenEditGoalIntent()),
                    ),
                    context.h(12),
                    EditProfileTapToEditField(
                      prefixTitle: "profile.your_activity_level".tr(),
                      controller: _activityDisplayController,
                      enabled: hasUser,
                      onClickTap: () => context
                          .read<EditProfileViewModel>()
                          .doIntent(const OpenEditActivityLevelIntent()),
                    ),
                    context.h(22),
                    ElevatedButton(
                      onPressed: isLoading ? null : _submitSave,
                      child: isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CircularProgressIndicator(),
                            )
                          : Text("save".tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitSave() {
    final viewModel = context.read<EditProfileViewModel>();
    final user = viewModel.state.currentUser;
    viewModel.doIntent(
      SubmitProfileIntent(
        UpdateUserDataRequest(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          gender: user.gender.name,
          height: user.height,
          age: user.age,
          weight: user.weight,
          goal: user.goal.name,
          activityLevel: user.activityLevel.toApiString(),
        ),
      ),
    );
  }

  Future<void> _pickImageAndUpload() async {
    final source = await _showImageSourceSheet();
    if (source == null || !mounted) return;

    final picked = await _imagePicker.pickImage(
      source: source,
      imageQuality: 85,
    );
    if (picked == null || !mounted) return;

    final image = File(picked.path);
    final viewModel = context.read<EditProfileViewModel>();
    viewModel.doIntent(SelectLocalPhotoIntent(image));
    viewModel.doIntent(UploadPhotoIntent(image));
  }

  Future<ImageSource?> _showImageSourceSheet() {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: context.appTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EditProfileImageSourceTile(
                icon: Icons.photo_library_outlined,
                title: "gallery".tr(),
                onTap: () => context.read<EditProfileViewModel>().doIntent(
                  const PickImageFromGalleryIntent(),
                ),
              ),
              EditProfileImageSourceTile(
                icon: Icons.camera_alt_outlined,
                title: "camera".tr(),
                onTap: () => context.read<EditProfileViewModel>().doIntent(
                  const PickImageFromCameraIntent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _goalLabel(UserGoal goal) => switch (goal) {
    UserGoal.gainWeight => "gain_weight".tr(),
    UserGoal.loseWeight => "lose_weight".tr(),
    UserGoal.getFitter => "get_fitter".tr(),
    UserGoal.gainMoreFlexible => "gain_more_flexible".tr(),
    UserGoal.learnTheBasics => "learn_the_basics".tr(),
  };

  String _activityLevelLabel(ActivityLevel level) => switch (level) {
    ActivityLevel.rookie => "rookie".tr(),
    ActivityLevel.beginner => "beginner".tr(),
    ActivityLevel.intermediate => "intermediate".tr(),
    ActivityLevel.advanced => "advanced".tr(),
    ActivityLevel.expert => "expert".tr(),
  };
}
