import 'category.dart';

/// A subsystem for reading data from the CategoryRepository needed to
/// generate a list of user's financial operations.
class OperationListItem
{
  final int _id;
  final Category _category;
  final DateTime _date;
  final double _price;

  OperationListItem({required int id, required Category category, required String date, required double price}) : _id = id, _category = category, _date = DateTime.parse(date), _price = price;

  int getId() => _id;
  Category getCategory() => _category;
  DateTime getDate() => _date;
  double getPrice() => _price;
}
