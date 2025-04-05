import 'package:flutter/material.dart';
import 'package:flutter_performance_pulse/flutter_performance_pulse.dart';
import 'package:dio/dio.dart';

void main() {
  // Initialize the performance monitor
  PerformanceMonitor.instance.initialize(
    config: const MonitorConfig(
      showMemory: true,
      showLogs: true,
      trackStartup: true,
      interceptNetwork: true,
      fpsWarningThreshold: 45,
      enableNetworkMonitoring: true,
      enableBatteryMonitoring: true,
      enableDeviceInfo: true,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pulse Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Dio _dio = Dio();
  bool _isLoading = false;

  // Simulate heavy computation
  void _performHeavyTask() {
    setState(() => _isLoading = true);

    // Create a large list and sort it
    final list = List.generate(1000000, (i) => 1000000 - i);
    list.sort();

    setState(() => _isLoading = false);
  }

  // Make a network request
  Future<void> _makeNetworkRequest() async {
    try {
      await _dio.get('https://jsonplaceholder.typicode.com/posts');
    } catch (e) {
      debugPrint('Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Pulse Demo'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _performHeavyTask,
                    child: const Text('Perform Heavy Task'),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _makeNetworkRequest,
                  child: const Text('Make Network Request'),
                ),
              ],
            ),
          ),
          // Add the performance dashboard
          const PerformanceDashboard(
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
        ],
      ),
    );
  }
}
