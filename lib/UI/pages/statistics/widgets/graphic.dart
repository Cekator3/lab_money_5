// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:lab_money_5/repositories/statistic_repository/DTO/statistic_entry.dart';

/// A subsystem for displaying financial
/// operations graphic to the user.
class GraphicWidget extends StatelessWidget
{
  final List<StatisticEntry> statisticEntries;

  const GraphicWidget({super.key, required this.statisticEntries});

  Map<String, double> _getStatisticsAsDataMap()
  {
    Map<String, double> dataMap = <String, double>{};
    for (final entry in statisticEntries)
    {
      double value = dataMap[entry.getCategoryName()] ?? 0.0;
      value += entry.getPrice();
      dataMap[entry.getCategoryName()] = value;
    }
    return dataMap;
  }

  @override
  Widget build(BuildContext context)
  {
    final dataMap = _getStatisticsAsDataMap();
    if (dataMap.isEmpty)
      return const Text('Статистики нет');
    return PieChart(
        dataMap: dataMap,
        chartType: ChartType.ring,
        baseChartColor: Colors.grey[300]!,
        colorList: statisticEntries.map((entry) => (entry.getCategoryColor())).toList(),
    );
  }
}
