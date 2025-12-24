import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/currency_history.dart';

class CurrencyHistoryChart extends StatelessWidget {
  final List<CurrencyHistory> history;

  const CurrencyHistoryChart({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const Center(child: Text('No historical data available.'));
    }

    final spots = List.generate(
      history.length,
      (i) => FlSpot(i.toDouble(), history[i].rate),
    );

    final minY = history.map((e) => e.rate).reduce((a, b) => a < b ? a : b);
    final maxY = history.map((e) => e.rate).reduce((a, b) => a > b ? a : b);

    final numberOfTicks = 4;

    final interval = (maxY - minY) / (numberOfTicks - 1);
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minY: minY,
          maxY: maxY,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: interval,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(3),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= history.length)
                    return const SizedBox.shrink();
                  final date = history[index].date;
                  return Text(
                    '${date.month}/${date.day}',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: interval,
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Colors.black12),
              left: BorderSide(color: Colors.black12),
              right: BorderSide(color: Colors.transparent),
              top: BorderSide(color: Colors.transparent),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 3,
              dotData: FlDotData(show: true),
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blue],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
