// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_money_5/UI/pages/statistics/widgets/category_type_buttons_widget.dart';
import 'package:lab_money_5/UI/pages/statistics/widgets/date_interval_buttons_widget.dart';
import 'package:lab_money_5/UI/pages/statistics/widgets/graphic.dart';
import 'package:lab_money_5/enums/category_type.dart';
import 'package:lab_money_5/repositories/statistic_repository/DTO/statistic_entry.dart';
import 'package:lab_money_5/repositories/statistic_repository/statistic_repository.dart';
import 'package:lab_money_5/repositories/statistic_repository/view_models/statistic_get_view_model.dart';

class StatisticsPage extends StatefulWidget
{
  final StatisticRepository statistics;

  const StatisticsPage({super.key, required this.statistics});

  @override
  State<StatefulWidget> createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage>
{
  DateTimeRange? _selectedDateRange;
  CategoryType? _selectedCategoryType;
  List<StatisticEntry> _statisticEntries = [];

  void _applyCategoryType(CategoryType type) async
  {
    setState(() {
      _selectedCategoryType = type;
    });

    if (_selectedDateRange == null)
      return;

    final filters = StatisticGetViewModel(
      from: _selectedDateRange!.start,
      to: _selectedDateRange!.end,
      type: type,
    );
    final statisticEntries = await widget.statistics.get(filters);

    setState(() {
      _statisticEntries = statisticEntries;
    });
  }

  void _applyDateInterval(DateTimeRange dateRange) async
  {
    setState(() {
      _selectedDateRange = dateRange;
    });

    if (_selectedCategoryType == null)
      return;

    final filters = StatisticGetViewModel(
      from: dateRange.start,
      to: dateRange.end,
      type: _selectedCategoryType!,
    );
    final statisticEntries = await widget.statistics.get(filters);

    setState(() {
      _statisticEntries = statisticEntries;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
      ),

      body: Column(
        children: [
          CategoryTypeButtonsWidget(onCategoryTypeSelect: _applyCategoryType),
          const SizedBox(height: 16),

          DateIntervalButtonsWidget(onIntervalSelect: _applyDateInterval),
          const SizedBox(height: 16),

          GraphicWidget(statisticEntries: _statisticEntries,)
        ],
      )
    );
  }
}
