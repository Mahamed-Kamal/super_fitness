import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_cubit.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/core/utils/local/app_local_storage.dart';
import 'package:super_fitness/core/utils/local/local_keys.dart';
import 'package:super_fitness/features/auth/domain/entity/logout_entity.dart';
import 'package:super_fitness/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_events.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_state.dart';

@injectable
class LogoutCubit
    extends BaseCubit<LogoutStates, LogoutEvents, LogoutUiEvents> {
  final LogoutUseCase _logoutUseCase;

  LogoutCubit(this._logoutUseCase) : super(const LogoutStates());

  final StreamController<LogoutUiEvents> _logoutUiEvent =
      StreamController.broadcast();

  Stream<LogoutUiEvents> get logoutUiEvent => _logoutUiEvent.stream;

  @override
  void doIntent(LogoutEvents event) {
    switch (event) {
      case LogoutEvent():
        _logout();
    }
  }

  void doEvent(LogoutUiEvents event) {
    switch (event) {
      case ShowToast():
        _logoutUiEvent.add(
          ShowToast(message: event.message, isError: event.isError),
        );
      case NavigateToLogin():
        _logoutUiEvent.add(NavigateToLogin());
      case NavigatePop():
        _logoutUiEvent.add(NavigatePop());
    }
  }

  void _logout() async {
    emit(
      state.copyWith(
        logoutState: const BaseState<LogoutEntity>(
          requestState: RequestState.loading,
        ),
      ),
    );
    Result<LogoutEntity> response = await _logoutUseCase.invoke();
    switch (response) {
      case SuccessResponse<LogoutEntity>():
        {
          emit(
            state.copyWith(
              logoutState: BaseState<LogoutEntity>.loaded(response.data),
            ),
          );
          await AppLocalStorage.clearSecuredData(key: LocalKeys.authToken);
          await AppLocalStorage.removeData(LocalKeys.user);
        }
      case FailureResponse<LogoutEntity>():
        emit(
          state.copyWith(
            logoutState: BaseState<LogoutEntity>.error(
              response.errorMessage.toString(),
            ),
          ),
        );
    }
  }
}
