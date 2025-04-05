import 'dart:async';
import 'base_tracker.dart';

/// Data class for CPU measurements
class CpuData {
  /// The current CPU usage percentage (0-100)
  final double usage;

  /// The number of cores
  final int cores;

  /// Creates a new CPU data instance
  const CpuData({required this.usage, required this.cores});
}

/// Tracks CPU usage
class CpuTracker extends BaseTracker {
  Timer? _timer;

  @override
  void onStart() {
    _timer = Timer.periodic(const Duration(seconds: 1), _checkCpu);
  }

  @override
  void onStop() {
    _timer?.cancel();
    _timer = null;
  }

  void _checkCpu(Timer timer) {
    // This is a simplified version. In a real implementation,
    // you would use platform-specific methods to get CPU usage
    final usage = _getCpuUsage();
    final cores = _getCpuCores();

    addData(CpuData(
      usage: usage,
      cores: cores,
    ));
  }

  double _getCpuUsage() {
    // Platform-specific implementation needed
    return 0.0;
  }

  int _getCpuCores() {
    // Platform-specific implementation needed
    return 1;
  }
}
