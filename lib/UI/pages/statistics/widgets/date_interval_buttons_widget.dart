import 'package:flutter/material.dart';
import 'package:lab_money_5/date_interval/date_interval.dart';

/// A subsystem for displaying to the user
/// buttons for selecting date interval
class DateIntervalButtonsWidget extends StatelessWidget
{
  final void Function(DateInterval) onIntervalSelect;

  const DateIntervalButtonsWidget({super.key, required this.onIntervalSelect});

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

  @override
  Widget build(BuildContext context)
  {
    return ToggleButtons(
      isSelected: [true, false, false, false, false],
      onPressed: (index) => {},
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
