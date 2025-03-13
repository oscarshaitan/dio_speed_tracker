# dio_speed_tracker

A lightweight and extensible **Dio interceptor** that tracks real-world network download speeds in **Mbps**, using actual HTTP responses instead of ICMP pings.

This is a practical alternative to [custom_ping](https://pub.dev/packages/custom_ping), ideal for apps where ICMP (ping) is blocked or unreliable — or when you want **real-world performance metrics** rather than synthetic ones.

---

## 🔍 Features

- ✅ Dio interceptor that measures network speed from actual downloads
- 📉 Emits `NetworkStatus.poor` when average speed drops below a threshold
- 🔄 Rolling average for smoothing out results
- ⚙️ Configurable sample size, duration, and thresholds
- 🧩 No platform channels or native code needed
- 👌 Suitable for Flutter & Dart web/server apps alike

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  dio: ^5.0.0
  collection: ^1.17.2
  dio_speed_tracker:
    git:
      url: https://github.com/your-username/dio_speed_tracker.git
```

---

## 🚀 Usage

### 1. Create and attach the interceptor

```dart
final speedController = NetworkSpeedController(
  maxSpeedSamples: 10,
  minResultsToCheck: 5,
  poorConnectionThreshold: 2.0, // Mbps
);

final dio = Dio();

dio.interceptors.add(
SpeedInterceptor(
speedController,
minTrackableSize: 10 * 1024, // 10 KB
minDuration: Duration(milliseconds: 20),
),
);
```

---

### 2. Listen for connection quality

```dart
speedController.stream.listen((status) {
if (status == NetworkStatus.poor) {
print("🚨 Poor connection detected!");
// Optionally show a UI warning or fallback
}
});
```

---

### 3. Clean up

Don't forget to dispose of the controller when no longer needed:

```dart
@override
void dispose() {
  speedController.dispose();
  super.dispose();
}
```

---

## 📊 How It Works

- The interceptor uses Dio's `onReceiveProgress` to measure how long a real HTTP download takes.
- It calculates **Mbps** based on size and duration.
- Speeds are stored in a rolling buffer, and the average is continuously evaluated.
- When the average falls below the defined threshold, it emits `NetworkStatus.poor` on the stream.

---

## 🆚 Why Not `custom_ping`?

Unlike [`custom_ping`](https://pub.dev/packages/custom_ping):

| Feature                         | `dio_speed_tracker` | `custom_ping` |
| ------------------------------ | ---------------------------- | ------------- |
| Real download-based speed      | ✅                           | ❌            |
| Works without ICMP permissions | ✅                           | ❌            |
| Cross-platform compatible      | ✅                           | 🚫 (native)   |
| Dio integration                | ✅                           | ❌            |
| No extra request calls         | ✅                           | ❌            |
| Single request evaluation      | ❌ (TBD)                     | ✅            |

---

## 🧪 Testing

This package includes full unit test coverage for:
- Speed sample tracking and averaging
- Rolling window logic
- Threshold stream emission
- Basic interceptor setup

### Run tests:

```bash
flutter test
```

You’ll find the test files in:

```
test/
├── network_speed_controller_test.dart
└── speed_interceptor_test.dart
```

---

## 🧰 Requirements

- Dart 2.17+
- Dio 5+
- `collection` package for calculating averages

---

## 📂 License

MIT License — free for personal or commercial use.

---

## 🙌 Contributing

Contributions and issues welcome!  
If you have improvements or new ideas, feel free to open a PR or start a discussion.

---

## 🔗 Links

- [custom_ping on pub.dev](https://pub.dev/packages/custom_ping) — the package this improves upon
- [Dio HTTP Client](https://pub.dev/packages/dio)
