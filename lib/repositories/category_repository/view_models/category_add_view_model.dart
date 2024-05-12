import 'dart:ui';

/// A subsystem for passing data into procedure "add" of CategoryRepository.
class CategoryAddViewModel
{
  final String name;
  final bool isIncome;
  final Color color;

  CategoryAddViewModel({required this.name, required this.isIncome, required this.color});
}
