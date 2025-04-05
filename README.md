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
  flutter_performance_pulse: ^1.0.2
```

## Usage Examples 📱

### Basic Setup

```dart
import 'package:flutter_performance_pulse/flutter_performance_pulse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize with default configuration
  await PerformanceMonitor.instance.initialize();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            const Positioned(
              right: 16,
              bottom: 16,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: PerformanceDashboard(
                  showFPS: true,
                  showCPU: true,
                  theme: DashboardTheme(
                    backgroundColor: Color(0xFF1E1E1E),
                    textColor: Colors.white,
                    warningColor: Colors.orange,
                    errorColor: Colors.red,
                    chartLineColor: Colors.blue,
                    chartFillColor: Color(0x40808080),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      home: const MyHomePage(),
    );
  }
}
```

### Advanced Configuration

```dart
await PerformanceMonitor.instance.initialize(
  config: MonitorConfig(
    // Performance monitoring options
    showMemory: true,
    showLogs: true,
    trackStartup: true,
    interceptNetwork: true,
    
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

### Custom Dashboard Theme

```dart
PerformanceDashboard(
  showFPS: true,
  showCPU: true,
  theme: DashboardTheme(
    backgroundColor: Colors.black87,
    textColor: Colors.white,
    warningColor: Colors.amber,
    errorColor: Colors.redAccent,
    chartLineColor: Colors.greenAccent,
    chartFillColor: Colors.greenAccent.withOpacity(0.2),
  ),
)
```

### Light Theme Example

```dart
PerformanceDashboard(
  showFPS: true,
  showCPU: true,
  theme: DashboardTheme.light(),
)
```

### Dark Theme Example

```dart
PerformanceDashboard(
  showFPS: true,
  showCPU: true,
  theme: DashboardTheme.dark(),
)
```

### Positioning the Dashboard

```dart
MaterialApp(
  builder: (context, child) {
    return Stack(
      children: [
        child!,
        // Top-right corner
        const Positioned(
          right: 16,
          top: 16,
          child: PerformanceDashboard(),
        ),
        
        // Or bottom-left corner
        const Positioned(
          left: 16,
          bottom: 16,
          child: PerformanceDashboard(),
        ),
        
        // Or any other position
        const Positioned(
          right: 16,
          bottom: 16,
          child: PerformanceDashboard(),
        ),
      ],
    );
  },
)
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
