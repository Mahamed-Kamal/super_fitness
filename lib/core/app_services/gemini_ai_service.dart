import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/constants/api_constants.dart';

@injectable
class GeminiAiService {
  late final GenerativeModel _model;
  late final String apiKey;
  GeminiAiService() {
    apiKey = ApiConstants.geminiApiKey;
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(
        "You are a professional Gym and Fitness assistant for the Super Fitness app. "
        "Your goal is to provide workout advice, nutrition tips, and exercise techniques. "
        "Strictly refuse to answer questions that are not related to fitness, health, gym, or nutrition. "
        "If a user asks about politics, movies, or coding, politely say: 'I am your fitness coach, let's stay focused on your goals!'",
      ),
    );
  }

  Future<String> getResponse(String prompt) async {
    try {
      final focusedPrompt = "Focusing only on fitness: $prompt";
      final content = [Content.text(focusedPrompt)];
      final response = await _model.generateContent(content);
      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('AI response was blocked or unavailable');
      }
      return text;
    } catch (e) {
      rethrow;
    }
  }
}
