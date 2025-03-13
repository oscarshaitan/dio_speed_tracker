#include "include/dio_speed_tracker/dio_speed_tracker_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "dio_speed_tracker_plugin.h"

void DioSpeedTrackerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  dio_speed_tracker::DioSpeedTrackerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
