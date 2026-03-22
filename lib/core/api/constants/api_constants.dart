import 'package:envied/envied.dart';
part 'api_constants.g.dart';

@Envied(path: 'env/.env')
class ApiConstants {
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static final String baseUrl = _ApiConstants.baseUrl;
}
