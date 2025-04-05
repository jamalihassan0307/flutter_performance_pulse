// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/dashboard_theme.dart';
import '../performance_monitor.dart';

/// A widget that displays performance metrics
class PerformanceDashboard extends StatefulWidget {
  /// Whether to show FPS metrics
  final bool showFPS;

  /// Whether to show CPU metrics
  final bool showCPU;

  /// The theme for the dashboard
  final DashboardTheme theme;

  /// Creates a new performance dashboard
  const PerformanceDashboard({
    super.key,
    this.showFPS = true,
    this.showCPU = true,
    this.theme = const DashboardTheme(
      backgroundColor: Color(0xFF1E1E1E),
      textColor: Colors.white,
      warningColor: Colors.orange,
      errorColor: Colors.red,
      chartLineColor: Colors.blue,
      chartFillColor: Color(0x40808080),
    ),
  });

  @override
  State<PerformanceDashboard> createState() => _PerformanceDashboardState();
}

class _PerformanceDashboardState extends State<PerformanceDashboard> {
  final List<FlSpot> _fpsData = [];
  final List<FlSpot> _cpuData = [];
  double _currentFps = 0;
  double _currentCpu = 0;
  int _dataIndex = 0;
  static const int _maxDataPoints = 50;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    final monitor = PerformanceMonitor.instance;

    if (widget.showFPS) {
      monitor.fpsStream.listen((data) {
        if (!mounted) return;
        setState(() {
          _currentFps = data.fps;
          _addDataPoint(_fpsData, data.fps);
        });
      });
    }

    if (widget.showCPU) {
      monitor.cpuStream.listen((data) {
        if (!mounted) return;
        setState(() {
          _currentCpu = data.usage;
          _addDataPoint(_cpuData, data.usage);
        });
      });
    }
  }

  void _addDataPoint(List<FlSpot> dataList, double value) {
    if (dataList.length >= _maxDataPoints) {
      dataList.removeAt(0);
      for (int i = 0; i < dataList.length; i++) {
        dataList[i] = FlSpot(i.toDouble(), dataList[i].y);
      }
    }
    dataList.add(FlSpot(dataList.length.toDouble(), value));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.theme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showFPS) ...[
            Text(
              'FPS: ${_currentFps.toStringAsFixed(1)}',
              style: TextStyle(
                color: _currentFps < 45 ? widget.theme.warningColor : widget.theme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildFPSChart(),
            const SizedBox(height: 16),
          ],
          if (widget.showCPU) ...[
            Text(
              'CPU: ${_currentCpu.toStringAsFixed(1)}%',
              style: TextStyle(
                color: _currentCpu > 80 ? widget.theme.warningColor : widget.theme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildCPUChart(),
          ],
        ],
      ),
    );
  }

  Widget _buildFPSChart() {
    return SizedBox(
      width: 200,
      height: 100,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 120,
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: _fpsData,
              isCurved: true,
              color: widget.theme.chartLineColor,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: widget.theme.chartFillColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCPUChart() {
    return SizedBox(
      width: 200,
      height: 100,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: _cpuData,
              isCurved: true,
              color: widget.theme.chartLineColor,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: widget.theme.chartFillColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
