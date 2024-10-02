import 'package:flutter/services.dart';

import 'native_notification_handler_platform_interface.dart';

class NativeNotificationHandler {
  static const MethodChannel _channel =
      MethodChannel('native_notification_handler');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> createNotificationChannel(
      String channelId, String channelName, String channelDescription) async {
    await _channel.invokeMethod('createNotificationChannel', {
      'channelId': channelId,
      'channelName': channelName,
      'channelDescription': channelDescription,
    });
  }

  static Future<void> showNotification(
      int id, String title, String body) async {
    await _channel.invokeMethod('showNotification', {
      'id': id,
      'title': title,
      'body': body,
    });
  }

  Future<String?> getPlatformVersion() {
    return NativeNotificationHandlerPlatform.instance.getPlatformVersion();
  }
}
