part of 'login_view_model.dart';

class LoginState extends Equatable {
  final BaseState<LoginResponseDto> loginState;
  const LoginState({required this.loginState});

  factory LoginState.initial() => LoginState(loginState: BaseState.init());

  LoginState copyWith({BaseState<LoginResponseDto>? loginState}) {
    return LoginState(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object?> get props => [loginState];
}
