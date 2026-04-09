import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/forget_password_entity.dart';
import 'package:super_fitness/features/auth/domain/entity/verify_reset_code_entity.dart';
import 'package:super_fitness/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:super_fitness/features/auth/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
part 'forget_password_state.dart';

@lazySingleton
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  ForgetPasswordViewModel(
    this._forgetPasswordUseCase,
    this._verifyResetCodeUseCase,
  ) : super(ForgetPasswordState());
  final StreamController<ForgetPasswordUiIntent> _intentStreamController =
      StreamController.broadcast();
  Timer? _timer;
  late int _remainingSeconds;

  Stream<ForgetPasswordUiIntent> get forgetPasswordUiEvent =>
      _intentStreamController.stream;

  void doIntent(ForgetPasswordIntent intent) {
    switch (intent) {
      case SendResetPasswordCodeIntent():
        {
          _sendResetPasswordCode(intent.email);
        }
      case VerifyResetCodeIntent():
        {
          _verifyResetCode(intent.verificationCode);
        }
      case ResendOtpIntent():
        {
          _resendOtp();
        }
    }
  }

  void doUiIntent(ForgetPasswordUiIntent intent) {
    switch (intent) {
      case ShowToast():
        {
          _intentStreamController.add(
            ShowToast(message: intent.message, isError: intent.isError),
          );
        }
      case NavigateToOtpViewIntent():
        {
          _intentStreamController.add(NavigateToOtpViewIntent());
        }
      case NavigateToResetPasswordViewIntent():
        {
          _intentStreamController.add(NavigateToResetPasswordViewIntent());
        }
    }
  }

  Future<void> _sendResetPasswordCode(String email) async {
    emit(
      state.copyWith(forgotPasswordState: BaseState.loading(), email: email),
    );
    var response = await _forgetPasswordUseCase.call(email: email);
    switch (response) {
      case SuccessResponse<ForgotPasswordEntity>():
        {
          emit(
            state.copyWith(
              forgotPasswordState: BaseState.loaded(response.data),
            ),
          );
          _resentOtpTimer();
        }
      case FailureResponse<ForgotPasswordEntity>():
        {
          emit(
            state.copyWith(
              forgotPasswordState: BaseState.error(response.errorMessage),
            ),
          );
        }
    }
  }

  Future<void> _verifyResetCode(String verificationCode) async {
    emit(state.copyWith(verifyResetCodeState: BaseState.loading()));
    var response = await _verifyResetCodeUseCase.call(
      resetCode: verificationCode,
    );
    switch (response) {
      case SuccessResponse<VerifyResetCodeEntity>():
        {
          emit(
            state.copyWith(
              verifyResetCodeState: BaseState.loaded(response.data),
            ),
          );
        }
      case FailureResponse<VerifyResetCodeEntity>():
        {
          emit(
            state.copyWith(
              verifyResetCodeState: BaseState.error(response.errorMessage),
            ),
          );
        }
    }
  }

  void _resentOtpTimer() {
    _timer?.cancel();
    _remainingSeconds = 30;
    emit(state.copyWith(resendRemainingSeconds: _remainingSeconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingSeconds--;
      if (_remainingSeconds > 0) {
        emit(state.copyWith(resendRemainingSeconds: _remainingSeconds));
      } else {
        timer.cancel();
        emit(state.copyWith(resendRemainingSeconds: 0));
      }
    });
  }

  void _resendOtp() {
    if (state.resendRemainingSeconds > 0 || state.email == null) {
      return;
    }

    _sendResetPasswordCode(state.email!);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
