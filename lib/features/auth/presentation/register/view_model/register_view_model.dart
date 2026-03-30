import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/bloc/base_view_model.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/domain/entities/register_step.dart';
import 'package:super_fitness/features/auth/domain/use_cases/register_use_case.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_event.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
// import 'package:super_fitness/features/auth/domain/use_cases/update_user_data_use_case.dart';

part 'register_state.dart';

class RegisterViewModel
    extends BaseViewModel<RegisterState, RegisterIntent, RegisterEvent> {
  final RegisterUseCase _registerUseCase;

  // final UpdateUserDataUseCase _updateUserDataUseCase;

  // String _authToken = '';

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
            : _saveFormAndProceed(
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
    }
  }

  void _goToStep(int step) => emit(state.copyWith(currentStep: step));

  void _updateFormData(RegisterFormData updated) =>
      emit(state.copyWith(formData: updated));

  void _navToLogin() => emitEvent(NavigateFromRegisterToLoginEvent());

  void _saveFormAndProceed(String email, password, firstName, lastName) {
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

  void _saveGenderAndProceed(String gender) {
    _updateFormData(state.formData.copyWith(gender: gender));
    _goToStep(RegisterStep.selectWeight.index);
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
        // _authToken = result.data;
        emit(
          state.copyWith(requestState: RequestState.loaded, data: result.data),
        );
        emitEvent(OnboardingCompletedEvent());

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

  // Future<void> _updateUserData() async {
  //   emit(state.copyWith(requestState: RequestState.loading));
  //
  //   final result = await _updateUserDataUseCase.call(
  //     token: _authToken,
  //     gender: state.formData.gender,
  //     height: state.formData.height,
  //     weight: state.formData.weight,
  //     age: state.formData.age,
  //     goal: state.formData.goal,
  //     activityLevel: state.formData.activityLevel,
  //   );
  //
  //   switch (result) {
  //     case SuccessResponse():
  //       emit(state.copyWith(requestState: RequestState.loaded));
  //       emitEvent(OnboardingCompletedEvent());
  //
  //     case FailureResponse():
  //       emit(
  //         state.copyWith(
  //           requestState: RequestState.error,
  //           errorMessage: result.errorMessage,
  //         ),
  //       );
  //       emitEvent(UpdateUserDataFailedEvent(message: result.errorMessage));
  //   }
  // }
}
