import 'dart:ui';
import '../enums/category_type.dart';

/// A subsystem for passing data into procedure "add" of CategoryRepository.
class CategoryAddViewModel
{
  final String name;
  final CategoryType type;
  final Color color;

  CategoryAddViewModel({required this.name, required this.type, required this.color});
}
