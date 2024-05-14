// ignore_for_file: curly_braces_in_flow_control_structures

import '../DTO/category.dart';
import '../DTO/operation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lab_money_5/database.dart';
import '../view_models/operation_add_view_model.dart';
import 'package:lab_money_5/repositories/operation_repository/view_models/operation_update_view_model.dart';

/// A subsystem for interacting with user's financial operations data stored
/// in a persistent storage (file or database).
class OperationsPersistentStorage
{
  Database? _db;

  bool _isInitialized()
  {
    return _db != null;
  }

  /// Initializes [OperationsPersistentStorage] object
  Future<void> init() async
  {
    if (_isInitialized())
      return;

    _db = await DB.getInstance();
  }

  Operation _convertToOperation(var entry)
  {
    return Operation(
      id: entry['id'],
      date: entry['date'],
      price: entry['price'],
      category: Category(
        id: entry['category_id'],
        name: entry['category_name'],
        color: entry['category_color']
      )
    );
  }

  /// Retrieves all existing user's financial operations
  ///
  /// Returns an empty list if error was encountered.
  Future<List<Operation>> getAll() async
  {
    if (! _isInitialized())
      throw Exception('OperationsPersistentStorage not initialized');

    var entries = await _db!.rawQuery(
      '''
      SELECT
          o.id        AS id,
          o.date      AS date,
          o.price     AS price,
          c.id        AS category_id,
          c.name      AS category_name,
          c.color     AS category_color

      FROM
          operations AS o
          INNER JOIN
              categories AS c
          ON
              o.category_id = c.id;
      '''
    );
    if (entries.isEmpty)
      return [];

    return entries.map((entry) => _convertToOperation(entry)).toList();
  }

  /// Retrieves user's financial operation
  ///
  /// Returns null if error was encountered.
  Future<Operation?> get(int id) async
  {
    if (! _isInitialized())
      throw Exception('OperationsPersistentStorage not initialized');

    var entry = await _db!.rawQuery(
      '''
      SELECT
          o.id        AS id,
          o.date      AS date,
          o.price     AS price,
          c.id        AS category_id,
          c.name      AS category_name,
          c.color     AS category_color

      FROM
          operations AS o
          INNER JOIN
              categories AS c
          ON
              o.category_id = c.id

      WHERE
        o.id = ?

      LIMIT 1
      ''',
      [id]
    );
    if (entry.isEmpty)
      return null;

    return _convertToOperation(entry.toList().first);
  }

  /// Adds a new financial operation for user.
  ///
  /// Nothing will be added if error was encountered.
  ///
  /// Returns operation's ID or null if error was encountered.
  Future<int?> add(OperationAddViewModel operation) async
  {
    if (! _isInitialized())
      throw Exception('OperationsPersistentStorage not initialized');

    return await _db!.rawInsert('''
      INSERT INTO
          operations (category_id, date, price)
      VALUES
          (?, ?, ?);
      ''',
      [operation.categoryId, operation.date.millisecondsSinceEpoch, operation.price]
    );
  }

  /// Updates user's financial operation
  ///
  /// Nothing will be updated if error was encountered.
  Future<void> update(OperationUpdateViewModel operation) async
  {
    if (! _isInitialized())
      throw Exception('OperationsPersistentStorage not initialized');

    await _db!.rawUpdate(
      '''
        UPDATE
            operations
        SET
            category_id = ?,
            date = ?,
            price = ?
        WHERE
            id = ?;
      ''',
      [operation.categoryId, operation.date.millisecondsSinceEpoch, operation.price, operation.id]
    );
  }

  /// Removes user's financial operation
  ///
  /// Nothing will be deleted if error was encountered or category not exists.
  Future<void> remove(int id) async
  {
    if (! _isInitialized())
      throw Exception('CategoriesPersistentStorage not initialized');

    await _db!.rawDelete(
      '''
        DELETE FROM
            operations
        WHERE
            id = ?;
      ''',
      [id]
    );
  }
}
