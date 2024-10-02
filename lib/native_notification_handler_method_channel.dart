import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_notification_handler_platform_interface.dart';

/// An implementation of [NativeNotificationHandlerPlatform] that uses method channels.
class MethodChannelNativeNotificationHandler extends NativeNotificationHandlerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_notification_handler');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
