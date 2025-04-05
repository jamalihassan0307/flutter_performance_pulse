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

<div align="center">
  <kbd>
    <img src="https://github.com/jamalihassan0307/flutter_performance_pulse/blob/main/image/logo.png?raw=true" width="250" alt="Flutter Performance Pulse"/>
  </kbd>
  
  <h1>🧠 Flutter Performance Pulse 🧠</h1>
  <p><i>Real-time performance monitoring toolkit for Flutter applications</i></p>
  
  <p align="center">
    <a href="https://github.com/jamalihassan0307">
      <img src="https://img.shields.io/badge/Created_by-Jam_Ali_Hassan-blue?style=for-the-badge&logo=github&logoColor=white" alt="Created by"/>
    </a>
  </p>

  <p align="center">
    <a href="https://github.com/jamalihassan0307">
      <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
    </a>
    <a href="https://www.linkedin.com/in/jamalihassan0307">
      <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
    </a>
    <a href="https://jamalihassan0307.github.io/portfolio.github.io">
      <img src="https://img.shields.io/badge/Portfolio-255E63?style=for-the-badge&logo=About.me&logoColor=white" alt="Portfolio"/>
    </a>
  </p>

  <p align="center">
    <a href="https://pub.dev/packages/flutter_performance_pulse">
      <img src="https://img.shields.io/pub/v/flutter_performance_pulse?style=for-the-badge&logo=dart&logoColor=white" alt="Pub Version"/>
    </a>
    <a href="https://flutter.dev">
      <img src="https://img.shields.io/badge/Platform-Flutter-02569B?style=for-the-badge&logo=flutter" alt="Platform"/>
    </a>
    <a href="https://opensource.org/licenses/MIT">
      <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge" alt="License: MIT"/>
    </a>
  </p>

  <p align="center">
    <a href="https://pub.dev/packages/flutter_performance_pulse">
      <img src="https://img.shields.io/pub/likes/flutter_performance_pulse?style=for-the-badge&logo=flutter&logoColor=white&label=Pub%20Likes" alt="Pub Likes"/>
    </a>
    <a href="https://pub.dev/packages/flutter_performance_pulse">
      <img src="https://img.shields.io/pub/points/flutter_performance_pulse?style=for-the-badge&logo=flutter&logoColor=white&label=Pub%20Points" alt="Pub Points"/>
    </a>
    <a href="https://pub.dev/packages/flutter_performance_pulse">
      <img src="https://img.shields.io/pub/popularity/flutter_performance_pulse?style=for-the-badge&logo=flutter&logoColor=white&label=Popularity" alt="Popularity"/>
    </a>
  </p>

</div>

# Flutter Performance Pulse 🧠

A real-time, in-app performance monitoring toolkit for Flutter. Designed to help developers detect bottlenecks, debug in production, and ensure a smooth user experience across platforms.

## Features ✨

- 📊 **Real-time FPS & Memory Usage Tracker**
  - Live FPS monitoring with tooltips
  - Heap memory usage tracking
  - Visual performance graphs
  - Optimized chart rendering

- 🚀 **CPU & GPU Monitoring**
  - CPU usage per core
  - GPU rendering statistics
  - Frame build time analysis
  - Reduced monitoring overhead

- 💾 **Disk Usage Monitor**
  - Total storage space tracking
  - Free space monitoring
  - App storage usage analysis
  - Visual disk usage graphs
  - Configurable warning thresholds
  - Automatic 5-second refresh
  - Enhanced error recovery

- 🛠️ **App Startup Time Analyzer**
  - Cold start measurements
  - Warm start tracking
  - First frame render timing
  - Performance optimization tips

- 🔍 **Network Request Logger**
  - API request monitoring
  - Response time tracking
  - Error logging
  - Detailed metrics analysis

- 📦 **Battery & Device Info**
  - Battery status monitoring
  - Device specifications
  - System resource usage
  - Platform-specific features

## Getting Started 🚀

Add Flutter Pulse to your pubspec.yaml:

```yaml
dependencies:
  flutter_performance_pulse: ^1.0.4
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
                  showDisk: true, // Enable disk monitoring
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
    diskWarningThreshold: 85.0, // Warn at 85% disk usage
    
    // Feature toggles
    enableNetworkMonitoring: true,
    enableBatteryMonitoring: true,
    enableDeviceInfo: true,
    enableDiskMonitoring: true,
    
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
  showDisk: true,
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
  showDisk: true,
  theme: DashboardTheme.light(),
)
```

### Dark Theme Example

```dart
PerformanceDashboard(
  showFPS: true,
  showCPU: true,
  showDisk: true,
  theme: DashboardTheme.dark(),
)
```

### Disk Monitoring Example

```dart
// Initialize with disk monitoring
await PerformanceMonitor.instance.initialize(
  config: MonitorConfig(
    enableDiskMonitoring: true,
    diskWarningThreshold: 85.0, // Show warning when disk usage exceeds 85%
  ),
);

// Add disk monitoring to dashboard
PerformanceDashboard(
  showDisk: true,
  theme: DashboardTheme.dark(),
)

// Test disk operations
Future<void> testDiskOperations() async {
  final appDir = await getApplicationDocumentsDirectory();
  final testFile = File('${appDir.path}/test_file.txt');
  
  // Write test data
  await testFile.writeAsString('Test data');
  
  // Get file stats
  final fileStats = await testFile.stat();
  print('File size: ${fileStats.size} bytes');
  
  // Clean up
  await testFile.delete();
}
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
