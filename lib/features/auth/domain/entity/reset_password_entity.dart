import 'package:equatable/equatable.dart';

class ResetPasswordEntity with EquatableMixin {
  final String? message;
  final String? info;

  ResetPasswordEntity({this.message, this.info});
  @override
  List<Object?> get props => [message, info];
}
