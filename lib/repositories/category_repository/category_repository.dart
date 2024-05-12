// ignore_for_file: curly_braces_in_flow_control_structures

import 'DTO/category.dart';
import 'DTO/category_list_item.dart';
import 'errors/category_add_errors.dart';
import 'errors/category_update_errors.dart';
import 'view_models/category_add_view_model.dart';
import 'view_models/category_update_view_model.dart';

/// A subsystem for interacting with stored data on financial operations categories.
class CategoryRepository
{
  /// Initializes [CategoryRepository] object
  Future<void> init() async
  {
    // 1. Initialize persistent storage
    // 2. Initialize in-memory cache
  }

  /// Retrieves all existing categories
  ///
  /// Returns an empty list if error was encountered.
  List<CategoryListItem> getAll()
  {
    // 1. Get from in-memory cache
  }

  /// Retrieves category's data
  ///
  /// Returns `null` if error occurred or category not exists.
  Category? get(int id)
  {
    // 1. Get from in-memory cache
  }

  /// Adds a new category
  ///
  /// Nothing will be added if error was encountered.
  Future<void> add(CategoryAddViewModel category, CategoryAddErrors errors) async
  {
    // 1. Try add to persistent storage
    // 2. Add to in-memory cache
  }

  /// Updates a category
  ///
  /// Nothing will be updated if error was encountered.
  Future<void> update(CategoryUpdateViewModel category, CategoryUpdateErrors errors) async
  {
    // 1. Try update in persistent storage
    // 2. Update in-memory cache
  }

  /// Removes a category
  ///
  /// Nothing will be deleted if error was encountered or category not exists.
  Future<void> remove(int id) async
  {
    // 1. Try remove from persistent storage
    // 2. Remove from in-memory cache
  }
}
