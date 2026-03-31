import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterViewModel extends Cubit<RegisterState> {
  // final RegisterUseCase _registerUseCase;

  RegisterViewModel() : super(RegisterInitial());
}
