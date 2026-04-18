import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/core/utils/local/app_local_storage.dart';
import 'package:super_fitness/core/utils/local/local_keys.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/domain/use_cases/login_use_case.dart';
import 'package:super_fitness/features/auth/presentation/login/view_model/login_intent.dart';

part 'login_state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final _uiEventsController = StreamController<LoginUIEvents>.broadcast();
  Stream<LoginUIEvents> get uiEventsStream => _uiEventsController.stream;
  LoginViewModel(this._loginUseCase) : super(LoginState.initial());

  void doIntent(Intent intent) {
    switch (intent) {
      case LoginIntent():
        _login(email: intent.email, password: intent.password);
      case FormChangedIntent():
        _onFormChanged(email: intent.email, password: intent.password);

      case RegisterIntent():
        _navigateToRegister();
      case ForgetPasswordIntent():
        _navigateToForgetPassword();
    }
  }

  void _onFormChanged({required String email, required String password}) {
    final isEnabled = email.isNotEmpty && password.isNotEmpty;

    if (isEnabled != state.isButtonEnabled) {
      emit(state.copyWith(isButtonEnabled: isEnabled));
    }
  }

  Future<void> _login({required String email, required String password}) async {
    emit(state.copyWith(loginState: state.loginState.loading));
    var response = await _loginUseCase.call(email: email, password: password);
    switch (response) {
      case SuccessResponse<LoginResponseDto>():
        await AppLocalStorage.setSecuredString(
          key: LocalKeys.authToken,
          value: response.data.token ?? '',
        );
        final user = response.data.user;
        if (user != null) {
          await AppLocalStorage.setSecuredString(
            key: LocalKeys.user,
            value: jsonEncode(user.toJson()),
          );
        }
        emit(
          state.copyWith(loginState: state.loginState.loaded(response.data)),
        );
        _uiEventsController.add(
          LoginViewShowToast(message: response.data.message ?? ""),
        );
      case FailureResponse<LoginResponseDto>():
        emit(
          state.copyWith(
            loginState: state.loginState.error(response.errorMessage),
          ),
        );
        _uiEventsController.add(
          LoginViewShowToast(message: response.errorMessage, isError: true),
        );
    }
  }

  void _navigateToRegister() => _uiEventsController.add(NavigateToRegister());
  void _navigateToForgetPassword() =>
      _uiEventsController.add(NavigateToForgetPassword());

  @override
  Future<void> close() {
    _uiEventsController.close();
    return super.close();
  }
}
