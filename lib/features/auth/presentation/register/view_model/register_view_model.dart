import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/bloc/base_view_model.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/domain/entities/register_step.dart';
import 'package:super_fitness/features/auth/domain/use_cases/register_use_case.dart';
import 'package:super_fitness/features/auth/domain/use_cases/update_user_data_use_case.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_event.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';

part 'register_state.dart';

@injectable
class RegisterViewModel
    extends BaseViewModel<RegisterState, RegisterIntent, RegisterEvent> {
  final RegisterUseCase _registerUseCase;
  final UpdateUserDataUseCase _updateUserDataUseCase;

  String _authToken = '';

  RegisterViewModel(this._registerUseCase, this._updateUserDataUseCase)
    : super(RegisterState.init());

  @override
  void doIntent(RegisterIntent intent) {
    switch (intent) {
      case RegisterButtonClickedIntent():
        _register();
      case LoginNavigationButtonClickedIntent():
        _navToLogin();

      case SwitchToSelectWeight():
        _goToStep(RegisterStep.selectWeight);
      case SwitchToSelectHeight():
        _goToStep(RegisterStep.selectHeight);
      case SwitchToSelectGoal():
        _goToStep(RegisterStep.selectGoal);
      case SwitchToSelectActivityLevel():
        _goToStep(RegisterStep.selectActivityLevel);

      case FinishOnboardingIntent():
        _updateUserData();

      case UpdateFirstNameIntent():
        _updateFormData(state.formData.copyWith(firstname: intent.value));
      case UpdateLastNameIntent():
        _updateFormData(state.formData.copyWith(lastname: intent.value));
      case UpdateEmailIntent():
        _updateFormData(state.formData.copyWith(email: intent.value));
      case UpdatePasswordIntent():
        _updateFormData(state.formData.copyWith(password: intent.value));
      case UpdateRePasswordIntent():
        _updateFormData(state.formData.copyWith(rePassword: intent.value));
      case UpdateGenderIntent():
        _updateFormData(state.formData.copyWith(gender: intent.gender));
      case UpdateWeightIntent():
        _updateFormData(state.formData.copyWith(weight: intent.weight));
      case UpdateHeightIntent():
        _updateFormData(state.formData.copyWith(height: intent.height));
      case UpdateAgeIntent():
        _updateFormData(state.formData.copyWith(age: intent.age));
      case UpdateGoalIntent():
        _updateFormData(state.formData.copyWith(goal: intent.goal));
      case UpdateActivityLevelIntent():
        _updateFormData(
          state.formData.copyWith(activityLevel: intent.activityLevel),
        );
    }
  }

  Future<void> _register() async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await _registerUseCase.call(
      firstName: state.formData.firstname,
      lastName: state.formData.lastname,
      email: state.formData.email,
      password: state.formData.password,
      rePassword: state.formData.rePassword,
      gender: state.formData.gender,
      height: state.formData.height,
      weight: state.formData.weight,
      age: state.formData.age,
      goal: state.formData.goal,
      activityLevel: state.formData.activityLevel,
    );

    switch (result) {
      case SuccessResponse<String>():
        _authToken = result.data;
        emit(
          state.copyWith(
            requestState: RequestState.loaded,
            data: result.data,
            currentStep: RegisterStep.selectGender,
          ),
        );
        emitEvent(
          UserRegisterSuccessfulEvent(message: 'user_register_success'),
        );

      case FailureResponse<String>():
        emit(
          state.copyWith(
            requestState: RequestState.error,
            errorMessage: result.errorMessage,
          ),
        );
        emitEvent(UserRegisterFailedEvent(message: result.errorMessage));
    }
  }

  Future<void> _updateUserData() async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await _updateUserDataUseCase.call(
      token: _authToken,
      gender: state.formData.gender,
      height: state.formData.height,
      weight: state.formData.weight,
      age: state.formData.age,
      goal: state.formData.goal,
      activityLevel: state.formData.activityLevel,
    );

    switch (result) {
      case SuccessResponse():
        emit(state.copyWith(requestState: RequestState.loaded));
        emitEvent(OnboardingCompletedEvent());

      case FailureResponse():
        emit(
          state.copyWith(
            requestState: RequestState.error,
            errorMessage: result.errorMessage,
          ),
        );
        emitEvent(UpdateUserDataFailedEvent(message: result.errorMessage));
    }
  }

  void _goToStep(RegisterStep step) =>
      emit(state.copyWith(requestState: RequestState.init, currentStep: step));

  void _updateFormData(RegisterFormData updated) =>
      emit(state.copyWith(formData: updated));

  void _navToLogin() => emitEvent(NavigateFromRegisterToLoginEvent());
}
