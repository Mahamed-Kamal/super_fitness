import 'package:super_fitness/core/error_handling/handle_exception.dart';
import 'package:super_fitness/core/error_handling/result.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() callApi) async {
  try {
    var result = await callApi.call();
    return SuccessResponse(data: result);
  } on Exception catch (e) {
    return FailureResponse(errorMessage: ExceptionHandler.getMessageError(e));
  }
}
