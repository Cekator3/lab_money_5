// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:lab_money_5/enums/category_type.dart';
import 'package:lab_money_5/repositories/category_repository/DTO/category.dart';

import 'DTO/statistic_entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lab_money_5/database.dart';
import 'view_models/statistic_get_view_model.dart';

/// A subsystem for reading stored statistical data on user's financial operations.
class StatisticRepository
{
  Database? _db;

  bool _isInitialized()
  {
    return _db != null;
  }

  /// Initializes [StatisticRepository] object
  Future<void> init() async
  {
    if (_isInitialized())
      return;

    _db = await DB.getInstance();
  }

  double _sumPrices(var entries)
  {
    double result = 0;
    for (var entry in entries)
      result += entry['price'];
    return result;
  }

  StatisticEntry _convertToStatisticEntry(var entry, double sumPrices)
  {
    return StatisticEntry(
      categoryName: entry['name'],
      categoryColor: entry['color'],
      share: entry['price'] / sumPrices,
      price: entry['price']
    );
  }

  /// Retrieves statistical data on a user's financial operations.
  ///
  /// Returns an empty list if error was encountered.
  Future<List<StatisticEntry>> get(StatisticGetViewModel search) async
  {
    if (!_isInitialized())
      throw Exception('StatisticRepository is not initialized');

    List params = [];
    if (search.type == CategoryType.income)
      params.add(1);
    else
      params.add(0);
    if (search.from != null)
      params.add(search.from!.millisecondsSinceEpoch);
    if (search.to != null)
      params.add(search.to!.millisecondsSinceEpoch);

    var entries = await _db!.rawQuery(
      '''
      SELECT
          c.name       AS name,
          c.color      AS color,
          SUM(price)   AS price

      FROM
          operations AS o
          INNER JOIN
              categories AS c
          ON
              o.category_id = c.id

      WHERE
          c.is_income = ?
          ${search.from == null ? '' : 'AND o.date >= ?'}
          ${search.to == null ? '' : 'AND o.date <= ?'}

      GROUP BY
          o.category_id

      ORDER BY
          price DESC;
      ''',
      params
    );

    final sumPrices = _sumPrices(entries);
    return entries.map((entry) => _convertToStatisticEntry(entry, sumPrices)).toList();
  }
}
