// ignore_for_file: curly_braces_in_flow_control_structures

import '../DTO/category_list_item.dart';
import '../view_models/category_add_view_model.dart';
import '../view_models/category_update_view_model.dart';
import 'errors/categories_persistent_storage_add_errors.dart';
import 'errors/categories_persistent_storage_update_errors.dart';

/// A subsystem for interacting with financial operations categories data stored
/// in a persistent storage (file or database).
class CategoriesPersistentStorage
{
  /// Initializes [CategoriesPersistanceStorage] object
  Future<void> init() async
  {
    // ...
  }

  /// Retrieves all existing categories
  ///
  /// Returns an empty list if error was encountered.
  Future<List<CategoryListItem>> getAll() async
  {
    // ...
  }

  /// Adds a new category
  ///
  /// Nothing will be added if error was encountered.
  Future<void> add(CategoryAddViewModel category, CategoriesPersistentStorageAddErrors errors) async
  {
    // ...
  }

  /// Updates a category
  ///
  /// Nothing will be updated if error was encountered.
  Future<void> update(CategoryUpdateViewModel category, CategoriesPersistentStorageUpdateErrors errors) async
  {
    // ...
  }

  /// Removes a category
  ///
  /// Nothing will be deleted if error was encountered or category not exists.
  Future<void> remove(int id) async
  {
    // ...
  }
}
