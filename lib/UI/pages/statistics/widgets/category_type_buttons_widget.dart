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

class _CategoryTypeButtonsWidgetState extends State<CategoryTypeButtonsWidget> {
  CategoryType _selectedCategoryType = CategoryType.loss;

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
      isSelected: [_selectedCategoryType == CategoryType.income, _selectedCategoryType == CategoryType.loss],
      onPressed: (index)
      {
        CategoryType type = index == 0
                            ? CategoryType.income
                            : CategoryType.loss;

        setState(() {
          _selectedCategoryType = type;
        });

        widget.onCategoryTypeSelect(type);
      },
      children: [
        _buildToggleButton('Доходы'),
        _buildToggleButton('Расходы'),
      ],
    );
  }
}
