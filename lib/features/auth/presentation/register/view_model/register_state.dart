part of 'register_view_model.dart';

class RegisterState extends BaseState<String> with EquatableMixin {
  final RegisterFormData formData;
  final int currentStep;

  final bool hasCompletedForm;

  const RegisterState({
    required super.requestState,
    super.errorMessage,
    super.data,
    this.formData = const RegisterFormData(),
    this.currentStep = 0,
    this.hasCompletedForm = false,
  });

  factory RegisterState.init() => const RegisterState(
    requestState: RequestState.init,
    formData: RegisterFormData(),
    currentStep: 0,
    hasCompletedForm: false,
  );

  factory RegisterState.loading({
    RegisterFormData? formData,
    int? currentStep,
    bool hasCompletedForm = false,
  }) => RegisterState(
    requestState: RequestState.loading,
    formData: formData ?? const RegisterFormData(),
    currentStep: currentStep ?? 0,
    hasCompletedForm: hasCompletedForm,
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
    int? currentStep,
    bool? hasCompletedForm,
  }) => RegisterState(
    requestState: requestState ?? this.requestState,
    errorMessage: errorMessage ?? this.errorMessage,
    data: data ?? this.data,
    formData: formData ?? this.formData,
    currentStep: currentStep ?? this.currentStep,
    hasCompletedForm: hasCompletedForm ?? this.hasCompletedForm,
  );

  @override
  List<Object?> get props => [
    requestState,
    errorMessage ?? '',
    data,
    formData,
    currentStep,
    hasCompletedForm,
  ];
}
