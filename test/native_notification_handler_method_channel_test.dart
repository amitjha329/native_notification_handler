import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_notification_handler/native_notification_handler_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelNativeNotificationHandler platform = MethodChannelNativeNotificationHandler();
  const MethodChannel channel = MethodChannel('native_notification_handler');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
