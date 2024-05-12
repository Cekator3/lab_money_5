import 'dart:ui';
import '../enums/category_type.dart';

/// A subsystem for reading data about certain category passed from the CategoryRepository.
class Category
{
  final int _id;
  final String _name;
  final bool _isIncome;
  final int _color;

  Category({required int id, required String name, required bool isIncome, required int color}) : _id = id, _name = name, _isIncome = isIncome, _color = color;

  int getId() => _id;
  String getName() => _name;
  CategoryType getType() => _isIncome ? CategoryType.income : CategoryType.loss;
  Color getColor() => Color(_color);
}
