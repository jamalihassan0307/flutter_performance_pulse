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
  final List<FlSpot> _fpsData = [const FlSpot(0, 60)]; // Start with a default value
  final List<FlSpot> _cpuData = [const FlSpot(0, 0)]; // Start with a default value
  double _currentFps = 60;
  double _currentCpu = 0;
  static const int _maxDataPoints = 30;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    if (widget.showFPS) {
      PerformanceMonitor.instance.fpsStream.listen((data) {
        if (!mounted) return;
        setState(() {
          _currentFps = data.fps;
          _addDataPoint(_fpsData, data.fps);
        });
      });
    }

    if (widget.showCPU) {
      PerformanceMonitor.instance.cpuStream.listen((data) {
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
      padding: const EdgeInsets.all(12),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showFPS) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.speed,
                  color: _currentFps < 45 ? widget.theme.warningColor : widget.theme.textColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'FPS: ${_currentFps.toStringAsFixed(1)}',
                  style: TextStyle(
                    color: _currentFps < 45 ? widget.theme.warningColor : widget.theme.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            _buildFPSChart(),
            const SizedBox(height: 12),
          ],
          if (widget.showCPU) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.memory,
                  color: _currentCpu > 80 ? widget.theme.warningColor : widget.theme.textColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'CPU: ${_currentCpu.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: _currentCpu > 80 ? widget.theme.warningColor : widget.theme.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            _buildCPUChart(),
          ],
        ],
      ),
    );
  }

  Widget _buildFPSChart() {
    return SizedBox(
      width: 160,
      height: 40,
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
      width: 160,
      height: 40,
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
