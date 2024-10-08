import 'dart:io';

class NetworkUtils {
  static Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {}

    return false;
  }
}
