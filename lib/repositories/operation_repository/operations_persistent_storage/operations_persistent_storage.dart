// ignore_for_file: curly_braces_in_flow_control_structures

import '../DTO/category_list_item.dart';

/// A subsystem for interacting with user's financial operations data stored
/// in a persistent storage (file or database).
class OperationsPersistentStorage
{
  /// Initializes [OperationsPersistentStorage] object
  Future<void> init() async
  {
    // ...
  }

  /// Retrieves all existing user's financial operations
  ///
  /// Returns an empty list if error was encountered.
  Future<List<CategoryListItem>> getAll() async
  {
    // ...
  }

  /// Adds a new financial operation for user.
  ///
  /// Nothing will be added if error was encountered.
  Future<void> add(CategoryAddViewModel category) async
  {
    // ...
  }

  /// Updates user's financial operation
  ///
  /// Nothing will be updated if error was encountered.
  Future<void> update(CategoryUpdateViewModel category) async
  {
    // ...
  }

  /// Removes user's financial operation
  ///
  /// Nothing will be deleted if error was encountered or category not exists.
  Future<void> remove(int id) async
  {
    // ...
  }
}
