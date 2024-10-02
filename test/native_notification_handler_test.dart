import 'package:flutter_test/flutter_test.dart';
import 'package:native_notification_handler/native_notification_handler.dart';
import 'package:native_notification_handler/native_notification_handler_platform_interface.dart';
import 'package:native_notification_handler/native_notification_handler_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeNotificationHandlerPlatform
    with MockPlatformInterfaceMixin
    implements NativeNotificationHandlerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativeNotificationHandlerPlatform initialPlatform = NativeNotificationHandlerPlatform.instance;

  test('$MethodChannelNativeNotificationHandler is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeNotificationHandler>());
  });

  test('getPlatformVersion', () async {
    NativeNotificationHandler nativeNotificationHandlerPlugin = NativeNotificationHandler();
    MockNativeNotificationHandlerPlatform fakePlatform = MockNativeNotificationHandlerPlatform();
    NativeNotificationHandlerPlatform.instance = fakePlatform;

    expect(await nativeNotificationHandlerPlugin.getPlatformVersion(), '42');
  });
}
