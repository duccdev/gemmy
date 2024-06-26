import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static String? apiKey;
  static GenerativeModel? model;
  static late SharedPreferences prefs;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
    reload();
  }

  static void reload() {
    apiKey = prefs.getString('apiKey');

    if (apiKey != null) {
      model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey!,
        safetySettings: [
          SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
          SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
          SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
          SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
        ],
      );
    }
  }
}
