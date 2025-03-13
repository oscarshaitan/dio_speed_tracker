import 'dart:async';

import 'package:collection/collection.dart';

/// Represents the current network status.
enum NetworkStatus { good, poor }

/// Tracks and analyzes network download speed over time.
/// Emits a signal through a stream when average speed drops below a threshold.
class NetworkSpeedController {
  /// The maximum number of recent speed samples to keep.
  final int maxSpeedSamples;

  /// The minimum number of results required before checking for poor speed.
  final int minResultsToCheck;

  /// Speed threshold in Mbps below which the connection is considered poor.
  final double poorConnectionThreshold;

  /// Stream controller to notify listeners about network status changes.
  final _controller = StreamController<NetworkStatus>.broadcast();

  /// List to store recent speed results in Mbps.
  final List<double> speedResults = [];

  /// Constructor for [NetworkSpeedController].
  NetworkSpeedController({this.maxSpeedSamples = 10, this.minResultsToCheck = 5, this.poorConnectionThreshold = 2.0});

  /// Adds a new speed measurement to the tracker.
  /// Triggers a poor connection check if there are enough samples.
  void addSpeed(double speed) {
    speedResults.add(speed);

    // Maintain a rolling list of speed samples.
    if (speedResults.length > maxSpeedSamples) {
      speedResults.removeAt(0);
    }

    if (speedResults.length >= minResultsToCheck) {
      if (averageSpeed < poorConnectionThreshold) {
        _controller.add(NetworkStatus.poor);
      }
    }
  }

  /// Calculates the average speed from the stored samples.
  double get averageSpeed => speedResults.isEmpty ? 0 : speedResults.average;

  /// Clears all stored speed samples.
  void resetSpeed() => speedResults.clear();

  /// Stream to subscribe to network status changes.
  Stream<NetworkStatus> get stream => _controller.stream;

  /// Closes the stream controller to free up resources.
  void dispose() {
    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}
