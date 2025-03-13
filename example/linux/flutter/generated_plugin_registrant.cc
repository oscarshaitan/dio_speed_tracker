//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dio_speed_tracker/dio_speed_tracker_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dio_speed_tracker_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DioSpeedTrackerPlugin");
  dio_speed_tracker_plugin_register_with_registrar(dio_speed_tracker_registrar);
}
