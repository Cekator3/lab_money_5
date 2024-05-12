// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:sqflite/sqflite.dart';
import '../DTO/operation_list_item.dart';
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

  /// Retrieves all existing user's financial operations
  ///
  /// Returns an empty list if error was encountered.
  Future<List<OperationListItem>> getAll() async
  {
    // ...
  }

  /// Adds a new financial operation for user.
  ///
  /// Nothing will be added if error was encountered.
  Future<void> add(OperationAddViewModel operation) async
  {
    // ...
  }

  /// Updates user's financial operation
  ///
  /// Nothing will be updated if error was encountered.
  Future<void> update(OperationUpdateViewModel operation) async
  {
    // ...
  }

  /// Removes user's financial operation
  ///
  /// Nothing will be deleted if error was encountered or category not exists.
  Future<void> remove(int id) async
  {
    if (! _isInitialized())
      throw Exception('CategoriesPersistentStorage not initialized');

    _db!.rawDelete(
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
