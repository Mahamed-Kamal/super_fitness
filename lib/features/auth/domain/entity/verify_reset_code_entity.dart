import 'package:equatable/equatable.dart';

class VerifyResetCodeEntity with EquatableMixin {
  final String? message;
  VerifyResetCodeEntity({this.message});
  @override
  List<Object?> get props => [message];
}
