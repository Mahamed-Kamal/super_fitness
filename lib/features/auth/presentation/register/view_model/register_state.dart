part of 'register_view_model.dart';

class RegisterState extends BaseState<String> {
  final RegisterFormData formData;

  const RegisterState({
    required super.requestState,
    super.errorMessage,
    super.data,
    this.formData = const RegisterFormData(),
  });

  factory RegisterState.init() => RegisterState(
    requestState: RequestState.init,
    formData: const RegisterFormData(),
  );

  factory RegisterState.loading([String? data]) =>
      RegisterState(requestState: RequestState.loading, data: data);

  factory RegisterState.loaded(String data) =>
      RegisterState(requestState: RequestState.loaded, data: data);

  factory RegisterState.error(String message) =>
      RegisterState(requestState: RequestState.error, errorMessage: message);

  RegisterState copyWith({
    RequestState? requestState,
    String? errorMessage,
    String? data,
    RegisterFormData? formData,
  }) => RegisterState(
    requestState: requestState ?? this.requestState,
    errorMessage: errorMessage ?? this.errorMessage,
    data: data ?? this.data,
    formData: formData ?? this.formData,
  );
}
