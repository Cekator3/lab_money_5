// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_money_5/enums/category_type.dart';

/// A subsystem for displaying to the user
/// buttons for selecting financial operations category type
class CategoryTypeButtonsWidget extends StatefulWidget
{
  final void Function(CategoryType) onCategoryTypeSelect;

  const CategoryTypeButtonsWidget({super.key, required this.onCategoryTypeSelect});

  @override
  State<CategoryTypeButtonsWidget> createState() => _CategoryTypeButtonsWidgetState();
}

class _CategoryTypeButtonsWidgetState extends State<CategoryTypeButtonsWidget>
{
  int _lastSelectedIdx = 1;

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
      isSelected: [_lastSelectedIdx == 0, _lastSelectedIdx == 1],
      onPressed: (index)
      {
        setState(() {
          _lastSelectedIdx = index;
        });

        CategoryType type = index == 0
                            ? CategoryType.loss
                            : CategoryType.income;

        widget.onCategoryTypeSelect(type);
      },
      children: [
        _buildToggleButton('Расходы'),
        _buildToggleButton('Доходы'),
      ],
    );
  }
}
