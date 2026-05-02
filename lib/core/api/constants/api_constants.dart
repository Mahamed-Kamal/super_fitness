import 'package:envied/envied.dart';
part 'api_constants.g.dart';

@Envied(path: 'env/.env')
class ApiConstants {
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static final String baseUrl = _ApiConstants.baseUrl;

  @EnviedField(varName: 'MEALS_BASE_URL', obfuscate: true)
  static final String mealsBaseUrl = _ApiConstants.mealsBaseUrl;
  @EnviedField(varName: 'GEMINI_API_KEY', obfuscate: true)
  static final String geminiApiKey = _ApiConstants.geminiApiKey;
}
