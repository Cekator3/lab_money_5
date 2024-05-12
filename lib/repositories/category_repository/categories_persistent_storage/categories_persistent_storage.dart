// ignore_for_file: curly_braces_in_flow_control_structures

import '../DTO/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lab_money_5/database.dart';
import '../view_models/category_add_view_model.dart';
import '../view_models/category_update_view_model.dart';
import 'errors/categories_persistent_storage_add_errors.dart';
import 'errors/categories_persistent_storage_update_errors.dart';
import 'package:lab_money_5/repositories/category_repository/enums/category_type.dart';

/// A subsystem for interacting with financial operations categories data stored
/// in a persistent storage (file or database).
class CategoriesPersistentStorage
{
  Database? _db;

  bool _isInitialized()
  {
    return _db != null;
  }

  /// Initializes [CategoriesPersistanceStorage] object
  Future<void> init() async
  {
    if (_isInitialized())
      return;

    _db = await DB.getInstance();
  }

  Category _convertToCategory(var entry)
  {
    return Category(
      id: entry['id'],
      name: entry['name'],
      color: entry['color'],
      isIncome: entry['is_income'] == 1
    );
  }

  /// Retrieves all existing categories
  ///
  /// Returns an empty list if error was encountered.
  Future<List<Category>> getAll() async
  {
    if (! _isInitialized())
      throw Exception('CategoriesPersistentStorage not initialized');

    var entries = await _db!.rawQuery(
      '''
      SELECT
          *
      FROM
          categories;
      '''
    );
    if (entries.isEmpty)
      return [];

    return entries.map((entry) => _convertToCategory(entry)).toList();
  }

  /// Adds a new category
  ///
  /// Nothing will be added if error was encountered.
  Future<void> add(CategoryAddViewModel category, CategoriesPersistentStorageAddErrors errors) async
  {
    if (! _isInitialized())
      throw Exception('CategoriesPersistentStorage not initialized');

    try
    {
      await _db!.rawInsert('''
        INSERT INTO
            categories (name, is_income, color)
        VALUES
            (?, ?, ?);
        ''',
        [category.name, category.type == CategoryType.income, category.color.value]
      );
    }
    on DatabaseException catch (e)
    {
      if (e.isUniqueConstraintError())
      {
        errors.add(errors.ALREADY_EXISTS);
        return;
      }
      rethrow;
    }
  }

  /// Updates a category
  ///
  /// Nothing will be updated if error was encountered.
  Future<void> update(CategoryUpdateViewModel category, CategoriesPersistentStorageUpdateErrors errors) async
  {
    if (! _isInitialized())
      throw Exception('CategoriesPersistentStorage not initialized');

    try
    {
      await _db!.rawUpdate(
        '''
          UPDATE
              categories
          SET
              name = ?,
              is_income = ?,
              color = ?
          WHERE
              id = ?;
        ''',
        [category.name, category.type == CategoryType.income, category.color.value, category.id]
      );
    }
    on DatabaseException catch (e)
    {
      if (e.isUniqueConstraintError())
      {
        errors.add(errors.ALREADY_EXISTS);
        return;
      }
      rethrow;
    }
  }

  /// Removes a category
  ///
  /// Nothing will be deleted if error was encountered or category not exists.
  Future<void> remove(int id) async
  {
    if (! _isInitialized())
      throw Exception('CategoriesPersistentStorage not initialized');

    _db!.rawDelete(
      '''
        DELETE FROM
            categories
        WHERE
            id = ?;
      ''',
      [id]
    );
  }
}
