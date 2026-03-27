import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel() : super(LoginInitial());
}
