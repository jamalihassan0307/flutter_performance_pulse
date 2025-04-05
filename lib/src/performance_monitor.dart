// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_pulse/src/config/monitor_config.dart';
import 'package:flutter_pulse/src/models/log_level.dart';
import 'package:flutter_pulse/src/trackers/battery_tracker.dart';
import 'package:flutter_pulse/src/trackers/cpu_tracker.dart';
import 'package:flutter_pulse/src/trackers/device_info_tracker.dart';
import 'package:flutter_pulse/src/trackers/fps_tracker.dart';
import 'package:flutter_pulse/src/trackers/memory_tracker.dart';
import 'package:flutter_pulse/src/trackers/network_tracker.dart';

/// The main performance monitoring class
class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();

  /// The singleton instance of the performance monitor
  static PerformanceMonitor get instance => _instance;

  late MonitorConfig _config;
  bool _isInitialized = false;

  // Trackers
  late FpsTracker _fpsTracker;
  late MemoryTracker _memoryTracker;
  late CpuTracker _cpuTracker;
  late NetworkTracker _networkTracker;
  late BatteryTracker _batteryTracker;
  late DeviceInfoTracker _deviceInfoTracker;

  PerformanceMonitor._internal();

  /// Initialize the performance monitor with the given configuration
  Future<void> initialize({MonitorConfig? config}) async {
    if (_isInitialized) {
      debugPrint('PerformanceMonitor is already initialized');
      return;
    }

    _config = config ?? const MonitorConfig();
    _isInitialized = true;

    // Initialize trackers
    _initializeTrackers();

    debugPrint('PerformanceMonitor initialized');
  }

  void _initializeTrackers() {
    if (_config.showMemory) {
      _memoryTracker = MemoryTracker();
    }

    _fpsTracker = FpsTracker(warningThreshold: _config.fpsWarningThreshold);

    if (_config.enableNetworkMonitoring) {
      _networkTracker = NetworkTracker();
    }

    if (_config.enableBatteryMonitoring) {
      _batteryTracker = BatteryTracker();
    }

    if (_config.enableDeviceInfo) {
      _deviceInfoTracker = DeviceInfoTracker();
    }

    _cpuTracker = CpuTracker();
  }

  /// Get the current configuration
  MonitorConfig get config => _config;

  /// Log a message at the specified level
  void log(String message, {LogLevel level = LogLevel.info}) {
    if (!_config.showLogs || !_config.logLevel.includes(level)) return;

    switch (level) {
      case LogLevel.verbose:
        debugPrint('🔍 VERBOSE: $message');
      case LogLevel.debug:
        debugPrint('🐛 DEBUG: $message');
      case LogLevel.info:
        debugPrint('ℹ️ INFO: $message');
      case LogLevel.warning:
        debugPrint('⚠️ WARNING: $message');
      case LogLevel.error:
        debugPrint('❌ ERROR: $message');
      case LogLevel.none:
        break;
    }
  }

  /// Start tracking app startup time
  void trackStartup() {
    if (!_config.trackStartup) return;
    // Implementation will be added
  }

  /// Dispose the performance monitor and its trackers
  void dispose() {
    _isInitialized = false;
    // Dispose trackers
  }
} 