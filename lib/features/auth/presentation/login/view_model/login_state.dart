part of 'login_view_model.dart';

class LoginState extends Equatable {
  final BaseState<LoginResponseDto> loginState;
  final bool isButtonEnabled;

  const LoginState({required this.loginState, required this.isButtonEnabled});

  factory LoginState.initial() =>
      LoginState(loginState: BaseState.init(), isButtonEnabled: false);

  LoginState copyWith({
    BaseState<LoginResponseDto>? loginState,
    bool? isButtonEnabled,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [loginState, isButtonEnabled];
}
