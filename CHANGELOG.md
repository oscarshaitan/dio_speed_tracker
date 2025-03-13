## [0.0.1] - 2025-03-13

- Initial release of `dio_speed_tracker`.
- Added `NetworkSpeedController` to track average download speed in Mbps.
- Added `SpeedInterceptor` to integrate with Dio and measure real request speed.
- Emits `NetworkStatus.poor` when connection speed drops below a defined threshold.
- Suitable as a real-world alternative to `custom_ping` with no ICMP or extra requests.
- Includes unit tests and Flutter example.

