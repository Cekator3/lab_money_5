// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_money_5/date_range_generator.dart';

/// A subsystem for displaying to the user
/// buttons for selecting date interval
class DateIntervalButtonsWidget extends StatefulWidget
{
  final void Function(DateTimeRange) onIntervalSelect;

  const DateIntervalButtonsWidget({super.key, required this.onIntervalSelect});

  @override
  State<DateIntervalButtonsWidget> createState() => _DateIntervalButtonsWidgetState();
}

class _DateIntervalButtonsWidgetState extends State<DateIntervalButtonsWidget>
{
  int _lastSelectedIdx = 1;
  DateTimeRange? _lastSelectedDateRange;

  Widget _buildToggleButton(String label)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<DateTimeRange?> _negotiateDateRange() async
  {
    return await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      currentDate: DateTime.now(),
      initialDateRange: _lastSelectedDateRange,
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return ToggleButtons(
      isSelected: [
        _lastSelectedIdx == 0,
        _lastSelectedIdx == 1,
        _lastSelectedIdx == 2,
        _lastSelectedIdx == 3,
        _lastSelectedIdx == 4
      ],
      onPressed: (index) async
      {
        DateTimeRange? dateRange = switch (index)
        {
          0 => DateRangeGenerator.thisDay(),
          1 => DateRangeGenerator.thisWeek(),
          2 => DateRangeGenerator.thisMonth(),
          3 => DateRangeGenerator.thisYear(),
          4 => await _negotiateDateRange(),
          _ => throw Exception('Not implemented')
        };

        if (dateRange == null)
          return;

        setState(() {
          _lastSelectedIdx = index;
          _lastSelectedDateRange = dateRange;
        });

        widget.onIntervalSelect(dateRange);
      },

      children: [
        _buildToggleButton('День'),
        _buildToggleButton('Неделя'),
        _buildToggleButton('Месяц'),
        _buildToggleButton('Год'),
        _buildToggleButton('Период')
      ],
    );
  }
}
