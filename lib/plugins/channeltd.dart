import 'dart:async';

import 'package:flutter/services.dart';

class FlutterCTD {
  static const MethodChannel _channel = const MethodChannel('chennl_t_D');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getA');
    return version;
  }
}
