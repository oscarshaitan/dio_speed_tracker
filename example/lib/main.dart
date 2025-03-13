import 'package:dio/dio.dart';
import 'package:dio_speed_tracker/dio_speed_tracker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final NetworkSpeedController _speedController;
  late final Dio _dio;
  String _statusMessage = "Waiting for download...";

  @override
  void initState() {
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

    super.initState();

    _speedController = NetworkSpeedController(
      maxSpeedSamples: 5,
      minResultsToCheck: 3,
      poorConnectionThreshold: 2.0, // Mbps
    );

    _dio = Dio();
    _dio.interceptors.add(
      SpeedInterceptor(
        _speedController,
        minTrackableSize: 5 * 1024,
        minDuration: Duration(microseconds: 500),
      ),
    );

    _speedController.stream.listen((status) {
      if (status == NetworkStatus.poor) {
        setState(() {
          _statusMessage = "🚨 Poor connection detected!";
        });
      }
    });
  }

  @override
  void dispose() {
    _speedController.dispose();
    super.dispose();
  }

  Future<void> _triggerDownload() async {
    setState(() {
      _statusMessage = "Downloading...";
    });

    try {
      ///replace with your url to test
      String url = "https://picsum.photos/id/4/5000/3333";
      await _dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      await _dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      await _dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      await _dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      await _dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      if (_speedController.speedResults.length >= 4) {
        setState(() {
          _statusMessage = "✅ Download complete. ${_speedController.speedResults}";
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "⚠️ Error during download.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('dio_speed_tracker Example')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_statusMessage, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _triggerDownload,
                  child: const Text("Start Test Download"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
