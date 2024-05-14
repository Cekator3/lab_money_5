import 'category.dart';

/// A subsystem for reading data about certain user's financial operation passed from the CategoryRepository.
class Operation
{
  final int _id;
  final Category _category;
  final DateTime _date;
  final double _price;

  Operation({required int id, required Category category, required String date, required double price}) : _id = id, _category = category, _date = DateTime.parse(date), _price = price;

  int getId() => _id;
  Category getCategory() => _category;
  DateTime getDate() => _date;
  double getPrice() => _price;
}
