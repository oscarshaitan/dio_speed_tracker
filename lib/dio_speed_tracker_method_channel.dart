import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dio_speed_tracker_platform_interface.dart';

/// An implementation of [DioSpeedTrackerPlatform] that uses method channels.
class MethodChannelDioSpeedTracker extends DioSpeedTrackerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dio_speed_tracker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
