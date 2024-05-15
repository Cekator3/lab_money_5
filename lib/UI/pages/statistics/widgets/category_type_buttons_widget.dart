import 'package:flutter/material.dart';
import 'package:lab_money_5/enums/category_type.dart';

/// A subsystem for displaying to the user
/// buttons for selecting financial operations category type
class CategoryTypeButtonsWidget extends StatelessWidget
{
  final void Function(CategoryType) onCategoryTypeSelect;

  const CategoryTypeButtonsWidget({super.key, required this.onCategoryTypeSelect});

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
      isSelected: [false, false],
      onPressed: (index) => {},
      children: [
        _buildToggleButton('Доходы'),
        _buildToggleButton('Расходы'),
      ],
    );
  }
}
