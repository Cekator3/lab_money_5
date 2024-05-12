import 'dart:ui';
import '../enums/category_type.dart';

/// A subsystem for passing data into procedure "update" of CategoryRepository.
class CategoryUpdateViewModel
{
  final String name;
  final CategoryType type;
  final Color color;

  CategoryUpdateViewModel({required this.name, required this.type, required this.color});
}
