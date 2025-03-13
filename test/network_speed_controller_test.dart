import 'package:dio_speed_tracker/dio_speed_tracker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkSpeedController', () {
    late NetworkSpeedController controller;

    setUp(() {
      controller = NetworkSpeedController(
        maxSpeedSamples: 3,
        minResultsToCheck: 2,
        poorConnectionThreshold: 2.0,
      );
    });

    tearDown(() {
      controller.dispose();
    });

    test('Initial average speed is 0', () {
      expect(controller.averageSpeed, 0);
    });

    test('Average speed is calculated correctly', () {
      controller.addSpeed(4.0);
      controller.addSpeed(2.0);
      expect(controller.averageSpeed, 3.0);
    });

    test('Rolls over maxSpeedSamples', () {
      controller.addSpeed(4.0);
      controller.addSpeed(2.0);
      controller.addSpeed(1.0);
      controller.addSpeed(3.0); // This should remove 4.0
      expect(controller.averageSpeed, closeTo((2.0 + 1.0 + 3.0) / 3, 0.01));
    });

    test('Emits NetworkStatus.poor when average is low', () async {
      final status = <NetworkStatus>[];

      controller.stream.listen(status.add);
      controller.addSpeed(1.0);
      controller.addSpeed(1.5);

      await Future.delayed(Duration.zero); // Allow stream to emit
      expect(status.contains(NetworkStatus.poor), isTrue);
    });
  });
}
