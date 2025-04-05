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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    final monitor = PerformanceMonitor.instance;

    if (widget.showFPS) {
      // Listen to FPS updates
    }

    if (widget.showCPU) {
      // Listen to CPU updates
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 16,
      child: Container(
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
            if (widget.showFPS) _buildFPSChart(),
            if (widget.showCPU) _buildCPUChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildFPSChart() {
    return SizedBox(
      width: 200,
      height: 100,
      child: LineChart(
        LineChartData(
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