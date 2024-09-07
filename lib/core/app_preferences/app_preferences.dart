import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _firstRunKey = 'first_run';

  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool(_firstRunKey) ?? true;

    if (isFirstRun) {
      await prefs.setBool(_firstRunKey, false);
    }

    return isFirstRun;
  }
}
