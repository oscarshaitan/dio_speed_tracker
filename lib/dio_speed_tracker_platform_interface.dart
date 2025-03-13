import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dio_speed_tracker_method_channel.dart';

abstract class DioSpeedTrackerPlatform extends PlatformInterface {
  /// Constructs a DioSpeedTrackerPlatform.
  DioSpeedTrackerPlatform() : super(token: _token);

  static final Object _token = Object();

  static DioSpeedTrackerPlatform _instance = MethodChannelDioSpeedTracker();

  /// The default instance of [DioSpeedTrackerPlatform] to use.
  ///
  /// Defaults to [MethodChannelDioSpeedTracker].
  static DioSpeedTrackerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DioSpeedTrackerPlatform] when
  /// they register themselves.
  static set instance(DioSpeedTrackerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
