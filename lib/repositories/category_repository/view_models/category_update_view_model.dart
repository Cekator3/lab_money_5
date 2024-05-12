import 'dart:ui';

/// A subsystem for passing data into procedure "update" of CategoryRepository.
class CategoryUpdateViewModel
{
  final String name;
  final bool isIncome;
  final Color color;

  CategoryUpdateViewModel({required this.name, required this.isIncome, required this.color});
}
