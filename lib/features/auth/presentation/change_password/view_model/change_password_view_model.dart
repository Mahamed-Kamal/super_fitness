import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_view_model.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/use_cases/change_user_password_use_case.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view_model/change_password_events.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view_model/change_password_intents.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view_model/change_password_state.dart';

@injectable
class ChangePasswordViewModel
    extends
        BaseViewModel<
          ChangePasswordState,
          ChangePasswordIntents,
          ChangePasswordEvents
        > {
  final ChangeUserPasswordUseCase _changeUserPasswordUseCase;

  ChangePasswordViewModel(this._changeUserPasswordUseCase)
    : super(ChangePasswordState.init());

  @override
  void doIntent(ChangePasswordIntents intent) {
    switch (intent) {
      case ChangePasswordButtonClick():
        _changeUserPassword(
          currentPassword: intent.currentPassword,
          newPassword: intent.newPassword,
        );
    }
  }

  void _changeUserPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordState.loading());
    var result = await _changeUserPasswordUseCase.call(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    switch (result) {
      case SuccessResponse<String>():
        emitEvent(ChangePasswordShowSuccessSnackBar());
        emitEvent(ChangePasswordNavToSettings());
        emit(ChangePasswordState.loaded(result.data));
      case FailureResponse<String>():
        emitEvent(ChangePasswordShowErrorSnackBar(result.errorMessage));
        emit(ChangePasswordState.error(result.errorMessage));
    }
  }
}
