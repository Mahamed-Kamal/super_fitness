import 'package:equatable/equatable.dart';

sealed class ChangePasswordIntents {}

class ChangePasswordButtonClick extends ChangePasswordIntents
    with EquatableMixin {
  final String currentPassword;
  final String newPassword;

  ChangePasswordButtonClick({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}
