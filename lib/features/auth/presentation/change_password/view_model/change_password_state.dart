import 'package:super_fitness/core/bloc/base_state.dart';

class ChangePasswordState extends BaseState<String> {
  const ChangePasswordState({
    required super.requestState,
    super.errorMessage,
    super.data,
  });

  factory ChangePasswordState.init() =>
      const ChangePasswordState(requestState: RequestState.init);

  factory ChangePasswordState.loading() =>
      ChangePasswordState(requestState: RequestState.loading);

  factory ChangePasswordState.loaded(String data) =>
      ChangePasswordState(requestState: RequestState.loaded, data: data);

  factory ChangePasswordState.error(String message) => ChangePasswordState(
    requestState: RequestState.error,
    errorMessage: message,
  );

  ChangePasswordState copyWith({
    RequestState? requestState,
    String? errorMessage,
    String? data,
  }) => ChangePasswordState(
    requestState: requestState ?? this.requestState,
    errorMessage: errorMessage ?? this.errorMessage,
    data: data ?? this.data,
  );

  @override
  List<Object?> get props => [requestState, errorMessage, data];
}
