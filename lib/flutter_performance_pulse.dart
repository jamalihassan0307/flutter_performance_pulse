library flutter_pulse;

export 'src/performance_monitor.dart';
export 'src/config/monitor_config.dart';
export 'src/widgets/performance_dashboard.dart';
export 'src/theme/dashboard_theme.dart';
export 'src/models/log_level.dart';
export 'src/trackers/fps_tracker.dart';
export 'src/trackers/memory_tracker.dart';
export 'src/trackers/cpu_tracker.dart';
export 'src/trackers/network_tracker.dart';
export 'src/trackers/battery_tracker.dart';
export 'src/trackers/device_info_tracker.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
