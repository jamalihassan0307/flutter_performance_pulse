<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Flutter Pulse 🧠

A real-time, in-app performance monitoring toolkit for Flutter. Designed to help developers detect bottlenecks, debug in production, and ensure a smooth user experience across platforms.

## Features ✨

- 📊 **Real-time FPS & Memory Usage Tracker**
  - Live FPS monitoring
  - Heap memory usage tracking
  - Visual performance graphs

- 🚀 **CPU & GPU Monitoring**
  - CPU usage per core
  - GPU rendering statistics
  - Frame build time analysis

- 🛠️ **App Startup Time Analyzer**
  - Cold start measurements
  - Warm start tracking
  - First frame render timing

- 🔍 **Network Request Logger**
  - API request monitoring
  - Response time tracking
  - Error logging

- 📦 **Battery & Device Info**
  - Battery status monitoring
  - Device specifications
  - System resource usage

## Getting Started 🚀

Add Flutter Pulse to your pubspec.yaml:

```yaml
dependencies:
  flutter_performance_pulse: ^1.0.1
```

## Basic Usage 📱

```dart
import 'package:flutter_pulse/flutter_pulse.dart';

// Initialize the performance monitor
void main() {
  PerformanceMonitor.instance.initialize(
    config: MonitorConfig(
      showMemory: true,
      showLogs: true,
      trackStartup: true,
      interceptNetwork: true,
    ),
  );
  
  runApp(MyApp());
}

// Add the dashboard to your widget tree
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          YourMainApp(),
          PerformanceDashboard(
            showFPS: true,
            showCPU: true,
            theme: DashboardTheme.dark(),
          ),
        ],
      ),
    );
  }
}
```

## Advanced Configuration 🔧

```dart
PerformanceMonitor.instance.initialize(
  config: MonitorConfig(
    // Performance thresholds
    fpsWarningThreshold: 45,
    memoryWarningThreshold: 500 * 1024 * 1024, // 500MB
    
    // Feature toggles
    enableNetworkMonitoring: true,
    enableBatteryMonitoring: true,
    enableDeviceInfo: true,
    
    // Logging options
    logLevel: LogLevel.verbose,
    exportLogs: true,
  ),
);
```

## Platform Support 🌍

| Platform | Support |
|----------|---------|
| Android  | ✅      |
| iOS      | ✅      |
| Web      | ✅      |
| macOS    | ⚠️ Limited |
| Windows  | ⚠️ Limited |
| Linux    | ⚠️ Limited |

## Contributing 🤝

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) to get started.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
