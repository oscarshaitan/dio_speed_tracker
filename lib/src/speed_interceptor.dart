import 'package:dio/dio.dart';

import 'network_speed_controller.dart';

/// Dio interceptor that measures download speed based on request/response times
/// and feeds it into a [NetworkSpeedController].
class SpeedInterceptor extends Interceptor {
  /// Controller to track network speed.
  final NetworkSpeedController speedTracker;

  /// Minimum size in bytes required to track speed.
  final double minTrackableSize;

  /// Minimum duration for a request to be considered trackable.
  final Duration minDuration;

  /// Creates a [SpeedInterceptor].
  SpeedInterceptor(
    this.speedTracker, {
    this.minTrackableSize = 5 * 1024, // 5 KB
    this.minDuration = const Duration(milliseconds: 10),
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final stopwatch = Stopwatch();

    // Set a custom receive progress callback to measure download duration.
    options.onReceiveProgress = (received, total) {
      // Start the stopwatch when download begins.
      if (received > 0) {
        stopwatch.start();
      }
      // When download completes and is large enough, calculate speed.
      if (stopwatch.isRunning &&
          received == total &&
          total >= minTrackableSize) {
        stopwatch.stop();

        // Only calculate speed if duration meets the minimum requirement.
        if (stopwatch.elapsed.compareTo(minDuration) >= 1) {
          final seconds = stopwatch.elapsed.inMilliseconds / 1000;
          final mbps =
              ((total / 1024) / 1024) / seconds * 8; // Convert bytes to Mbps

          // Add the calculated speed to the tracker.
          speedTracker.addSpeed(mbps);
        }
      }
    };

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Treat certain error types as zero-speed events.
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      speedTracker.addSpeed(0);
    }

    super.onError(err, handler);
  }
}
