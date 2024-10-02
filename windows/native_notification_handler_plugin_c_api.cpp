#include "include/native_notification_handler/native_notification_handler_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "native_notification_handler_plugin.h"

void NativeNotificationHandlerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  native_notification_handler::NativeNotificationHandlerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
