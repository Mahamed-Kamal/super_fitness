import 'package:equatable/equatable.dart';

sealed class Result<T> extends Equatable {}

class SuccessResponse<T> extends Result<T> {
  final T data;
  SuccessResponse({required this.data});

  @override
  List<Object?> get props => [data];
}

class FailureResponse<T> extends Result<T> {
  final String errorMessage;
  FailureResponse({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
