import 'package:verifeye/enums/enum.dart';

class Navigate {
  Map<String, dynamic> choosePage(page) {
    switch (page) {
      case NavigationPages.home:
        return {
          'index': 0,
        };
      case NavigationPages.search:
        return {
          'index': 1,
        };
      case NavigationPages.settings:
        return {
          'index': 2,
        };

      default:
        return {
          'index': 0,
        };
    }
  }
}
