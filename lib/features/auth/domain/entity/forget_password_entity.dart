import 'package:equatable/equatable.dart';

class ForgotPasswordEntity with EquatableMixin{
  final String? message;
  final String? info;

  ForgotPasswordEntity ({
    this.message,
    this.info,
  });

  @override

  List<Object?> get props => [message,info];

}


