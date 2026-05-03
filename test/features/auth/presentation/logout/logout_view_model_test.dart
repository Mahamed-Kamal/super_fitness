import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/logout_entity.dart';
import 'package:super_fitness/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_events.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_state.dart';
import 'package:super_fitness/features/auth/presentation/logout/logout_view_model.dart';

import 'logout_view_model_test.mocks.dart';

@GenerateMocks([LogoutUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockLogoutUseCase mockUseCase;
  late LogoutCubit viewModel;
  late LogoutEntity dummyResponse;

  setUp(() {
    mockUseCase = MockLogoutUseCase();
    viewModel = LogoutCubit(mockUseCase);

    dummyResponse = LogoutEntity(message: "success");
    provideDummy<Result<LogoutEntity>>(
      SuccessResponse<LogoutEntity>(data: dummyResponse),
    );
  });

  blocTest<LogoutCubit, LogoutStates>(
    ' emits [loading, success] when logoutUseCase returns Success',
    build: () {
      when(mockUseCase.invoke()).thenAnswer(
        (_) async => SuccessResponse<LogoutEntity>(data: dummyResponse),
      );
      return viewModel;
    },
    act: (bloc) => bloc.doIntent(LogoutEvent()),
    expect: () {
      var state = const LogoutStates(
        logoutState: BaseState<LogoutEntity>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          logoutState: const BaseState<LogoutEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          logoutState: BaseState<LogoutEntity>(
            requestState: RequestState.loaded,
            data: dummyResponse,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(mockUseCase.invoke()).called(1);
    },
  );

  blocTest<LogoutCubit, LogoutStates>(
    ' emits [loading, error] when logoutUseCase returns error',
    build: () {
      when(mockUseCase.invoke()).thenAnswer(
        (_) async => FailureResponse<LogoutEntity>(errorMessage: "Failed"),
      );
      return viewModel;
    },
    act: (bloc) => bloc.doIntent(LogoutEvent()),
    expect: () {
      var state = const LogoutStates(
        logoutState: BaseState<LogoutEntity>(
          requestState: RequestState.loading,
        ),
      );
      return [
        state.copyWith(
          logoutState: const BaseState<LogoutEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          logoutState: const BaseState<LogoutEntity>(
            errorMessage: "Failed",
            requestState: RequestState.error,
          ),
        ),
      ];
    },
    verify: (_) {
      verify(mockUseCase.invoke()).called(1);
    },
  );
}
