import 'package:flutter/foundation.dart';

/// @author Acorn
/// @version
/// @company 威成亚
/// @date 2025/2/18

class Logger {
  static void log(String str) {
    if (kDebugMode) {
      print(str);
    }
  }
}
