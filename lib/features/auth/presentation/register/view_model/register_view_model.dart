import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/bloc/base_view_model.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entities/register_form_data.dart';
import 'package:super_fitness/features/auth/domain/use_cases/register_use_case.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_event.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';

part 'register_state.dart';

class RegisterViewModel
    extends BaseViewModel<RegisterState, RegisterIntent, RegisterEvent> {
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase) : super(RegisterState.init());

  @override
  void doIntent(RegisterIntent intent) {
    switch (intent) {
      case RegisterButtonClickedIntent():
        _register();
      case LoginNavigationButtonClickedIntent():
        _navToLogin();
      case SwitchToSelectGender():
        // TODO: Handle this case.
        throw UnimplementedError();
      case SwitchToSelectAge():
        // TODO: Handle this case.
        throw UnimplementedError();
      case SwitchToSelectWeight():
        // TODO: Handle this case.
        throw UnimplementedError();
      case SwitchToSelectHeight():
        // TODO: Handle this case.
        throw UnimplementedError();
      case SwitchToSelectGoal():
        // TODO: Handle this case.
        throw UnimplementedError();
      case SwitchToSelectActivityLevel():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  Future<void> _register() async {
    emit(RegisterState.loading());
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
        emit(RegisterState.loaded(result.data));
        emitEvent(
          UserRegisterSuccessfulEvent(message: 'user_register_success'),
        );
      case FailureResponse<String>():
        emit(RegisterState.error(result.errorMessage));
        emitEvent(UserRegisterFailedEvent(message: result.errorMessage));
    }
  }

  void _navToLogin() => emitEvent(NavigateFromRegisterToLoginEvent());
}
