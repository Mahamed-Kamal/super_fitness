import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/domain/use_cases/register_use_case.dart';

part 'register_state.dart';

class RegisterViewModel extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase) : super(RegisterInitial());
}
