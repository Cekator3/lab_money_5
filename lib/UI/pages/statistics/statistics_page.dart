import 'package:flutter/material.dart';
import 'package:lab_money_5/UI/pages/statistics/widgets/category_type_buttons_widget.dart';
import 'package:lab_money_5/UI/pages/statistics/widgets/date_interval_buttons_widget.dart';
import 'package:lab_money_5/date_interval/date_interval.dart';
import 'package:lab_money_5/enums/category_type.dart';
import 'package:lab_money_5/repositories/statistic_repository/statistic_repository.dart';

class StatisticsPage extends StatefulWidget
{
  final StatisticRepository statistics;

  const StatisticsPage({super.key, required this.statistics});

  @override
  State<StatefulWidget> createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage>
{
  void _applyCategoryType(CategoryType type)
  {
    // ...
  }

  void _applyDateInterval(DateInterval interval)
  {
    // ...
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

          // Graphic
        ],
      )
    );
  }
}
