part of 'register_view_model.dart';

class RegisterState extends BaseState<String> {
  final RegisterFormData formData;

  final RegisterStep currentStep;

  const RegisterState({
    required super.requestState,
    super.errorMessage,
    super.data,
    this.formData = const RegisterFormData(),
    this.currentStep = RegisterStep.registerForm,
  });

  factory RegisterState.init() => const RegisterState(
    requestState: RequestState.init,
    formData: RegisterFormData(),
    currentStep: RegisterStep.registerForm,
  );

  factory RegisterState.loading({
    RegisterFormData? formData,
    RegisterStep? currentStep,
  }) => RegisterState(
    requestState: RequestState.loading,
    formData: formData ?? const RegisterFormData(),
    currentStep: currentStep ?? RegisterStep.registerForm,
  );

  factory RegisterState.loaded(String data) =>
      RegisterState(requestState: RequestState.loaded, data: data);

  factory RegisterState.error(String message) =>
      RegisterState(requestState: RequestState.error, errorMessage: message);

  RegisterState copyWith({
    RequestState? requestState,
    String? errorMessage,
    String? data,
    RegisterFormData? formData,
    RegisterStep? currentStep,
  }) => RegisterState(
    requestState: requestState ?? this.requestState,
    errorMessage: errorMessage ?? this.errorMessage,
    data: data ?? this.data,
    formData: formData ?? this.formData,
    currentStep: currentStep ?? this.currentStep,
  );
}
