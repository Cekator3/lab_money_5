import 'package:lab_money_5/enums/category_type.dart';

/// A subsystem for passing data into function "get" of StatisticRepository.
class StatisticGetViewModel
{
  final DateTime? from;
  final DateTime? to;
  final CategoryType type;

  StatisticGetViewModel({this.from, this.to, required this.type});
}
