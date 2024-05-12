import 'dart:ui';

/// A subsystem for reading data about financial operation's category
/// passed from the OperationRepository
class Category
{
  final int _id;
  final String _name;
  final int _color;

  Category({required int id, required String name, required int color}) : _id = id, _name = name, _color = color;

  int getId() => _id;
  String getName() => _name;
  Color getColor() => Color(_color);
}
