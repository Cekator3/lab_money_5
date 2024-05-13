import 'dart:ui';

/// A subsystem for reading data from the StatisticRepository needed to
/// generate a statistic of user's financial operations.
class StatisticEntry
{
  final int _categoryColor;
  final String _categoryName;
  final double _share;
  final double _price;

  StatisticEntry({required int categoryColor, required String categoryName, required double share, required double price}) : _categoryColor = categoryColor, _categoryName = categoryName, _share = share, _price = price;

  Color getCategoryColor() => Color(_categoryColor);
  String getCategoryName() => _categoryName;
  double getShareInPercents() => _share;
  double getPrice() => _price;
}
