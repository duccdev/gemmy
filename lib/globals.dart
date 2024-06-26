import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static String? model;
  static String? apiKey;
  static late SharedPreferences prefs;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
    reload();
  }

  static void reload() {
    model = prefs.getString('model');
    apiKey = prefs.getString('apiKey');
  }
}
