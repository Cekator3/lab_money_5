import 'dart:ui';

/// A subsystem for reading data from the CategoryRepository needed to
/// generate a list of categories.
class CategoryListItem
{
  final int _id;
  final String _name;
  final int _color;

  CategoryListItem({required int id, required String name, required int color}) : _id = id, _name = name, _color = color;

  int getId() => _id;
  String getName() => _name;
  Color getColor() => Color(_color);
}
