import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/bloc/base_view_model.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/domain/entities/register_step.dart';
import 'package:super_fitness/features/auth/domain/use_cases/register_use_case.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_event.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';

part 'register_state.dart';

@injectable
class RegisterViewModel
    extends BaseViewModel<RegisterState, RegisterIntent, RegisterEvent> {
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase) : super(RegisterState.init());

  @override
  void doIntent(RegisterIntent intent) {
    switch (intent) {
      case LoginNavigationButtonClickedIntent():
        _navToLogin();

      case RegisterStepNavBackIntent():
        _goStepBack();

      case RegisterButtonClickedIntent():
        state.hasCompletedForm
            ? _callRegisterApi()
            : _saveRegisterFormAndProceed(
                intent.email,
                intent.password,
                intent.firstName,
                intent.lastName,
              );

      case SwitchViewToSelectWeight():
        _saveGenderAndProceed(intent.userGender.name);

      case SwitchViewToSelectHeight():
        _saveWeightAndProceed(intent.weight);

      case SwitchViewToSelectGoal():
        _saveHeightAndProceed(intent.height);

      case SwitchViewToSelectActivityLevel():
        _saveGoalAndProceed(intent.goal.name);

      case FinishRegisterIntent():
        _saveActivityLevelAndRegister(intent.activityLevel.name);

      case SwitchViewToSelectAge():
        _saveAgeAndProceed(intent.age);
    }
  }

  void _goToStep(int step) => emit(state.copyWith(currentStep: step));

  void _updateFormData(RegisterFormData updated) =>
      emit(state.copyWith(formData: updated));

  void _navToLogin() => emitEvent(NavigateFromRegisterToLoginEvent());

  void _saveRegisterFormAndProceed(
    String email,
    String password,
    String firstName,
    String lastName,
  ) {
    _updateFormData(
      state.formData.copyWith(
        firstname: firstName,
        lastname: lastName,
        email: email,
        password: password,
        rePassword: password,
      ),
    );
    _goToStep(RegisterStep.selectGender.index);
  }

  void _saveAgeAndProceed(int age) {
    _updateFormData(state.formData.copyWith(age: age));
    _goToStep(RegisterStep.selectWeight.index);
  }

  void _saveGenderAndProceed(String gender) {
    _updateFormData(state.formData.copyWith(gender: gender));
    _goToStep(RegisterStep.selectAge.index);
  }

  void _saveWeightAndProceed(int weight) {
    _updateFormData(state.formData.copyWith(weight: weight));
    _goToStep(RegisterStep.selectHeight.index);
  }

  void _saveHeightAndProceed(int height) {
    _updateFormData(state.formData.copyWith(height: height));
    _goToStep(RegisterStep.selectGoal.index);
  }

  void _saveGoalAndProceed(String goal) {
    _updateFormData(state.formData.copyWith(goal: goal));
    _goToStep(RegisterStep.selectActivityLevel.index);
  }

  void _saveActivityLevelAndRegister(String activityLevel) {
    _updateFormData(state.formData.copyWith(activityLevel: activityLevel));
    _callRegisterApi();
  }

  Future<void> _callRegisterApi() async {
    emit(
      state.copyWith(
        requestState: RequestState.loading,
        hasCompletedForm: true,
      ),
    );
    late String level;
    switch (state.formData.activityLevel) {
      case 'rookie':
        level = 'level1';
        break;
      case 'beginner':
        level = 'level2';
        break;
      case 'intermediate':
        level = 'level3';
        break;
      case 'advanced':
        level = 'level4';
        break;
      case 'expert':
        level = 'level5';
        break;
    }

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
      activityLevel: level,
    );

    switch (result) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(requestState: RequestState.loaded, data: result.data),
        );
        emitEvent(RegisterCompletedEvent());

      case FailureResponse<String>():
        emit(
          state.copyWith(
            requestState: RequestState.error,
            errorMessage: result.errorMessage,
            currentStep: RegisterStep.registerForm.index,
            hasCompletedForm: true,
          ),
        );
        emitEvent(UserRegisterFailedEvent(message: result.errorMessage));
    }
  }

  void _goStepBack() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    } else {
      emitEvent(NavigateFromRegisterToLoginEvent());
    }
  }
}
