#ifndef FLUTTER_PLUGIN_NATIVE_NOTIFICATION_HANDLER_PLUGIN_H_
#define FLUTTER_PLUGIN_NATIVE_NOTIFICATION_HANDLER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace native_notification_handler {

class NativeNotificationHandlerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  NativeNotificationHandlerPlugin();

  virtual ~NativeNotificationHandlerPlugin();

  // Disallow copy and assign.
  NativeNotificationHandlerPlugin(const NativeNotificationHandlerPlugin&) = delete;
  NativeNotificationHandlerPlugin& operator=(const NativeNotificationHandlerPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace native_notification_handler

#endif  // FLUTTER_PLUGIN_NATIVE_NOTIFICATION_HANDLER_PLUGIN_H_
