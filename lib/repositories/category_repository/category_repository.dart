// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:lab_money_5/repositories/category_repository/categories_persistent_storage/categories_persistent_storage.dart';
import 'package:lab_money_5/repositories/category_repository/categories_persistent_storage/errors/categories_persistent_storage_add_errors.dart';
import 'package:lab_money_5/repositories/category_repository/categories_persistent_storage/errors/categories_persistent_storage_update_errors.dart';
import 'package:lab_money_5/repositories/category_repository/enums/category_type.dart';

import 'DTO/category.dart';
import 'DTO/category_list_item.dart';
import 'errors/category_add_errors.dart';
import 'errors/category_update_errors.dart';
import 'view_models/category_add_view_model.dart';
import 'view_models/category_update_view_model.dart';

/// A subsystem for interacting with stored data on financial operations categories.
class CategoryRepository
{
  List<Category> _categoriesCache = [];
  final CategoriesPersistentStorage _categoriesStorage = CategoriesPersistentStorage();

  /// Initializes [CategoryRepository] object
  Future<void> init() async
  {
    await _categoriesStorage.init();
    _categoriesCache = await _categoriesStorage.getAll();
  }

  /// Retrieves all existing categories
  ///
  /// Returns an empty list if error was encountered.
  List<CategoryListItem> getAll()
  {
    // Get from cache
    return _categoriesCache.map((category) =>
      CategoryListItem(
        id: category.getId(),
        name: category.getName(),
        color: category.getColor().value
      )
    ).toList();
  }

  /// Retrieves category's data
  ///
  /// Returns `null` if error occurred or category not exists.
  Category? get(int id)
  {
    // Get from cache
    for (Category category in _categoriesCache)
      if (category.getId() == id)
        return category;
    return null;
  }

  /// Adds a new category
  ///
  /// Nothing will be added if error was encountered.
  Future<void> add(CategoryAddViewModel category, CategoryAddErrors errors) async
  {
    // Add to storage
    final storageErrors = CategoriesPersistentStorageAddErrors();
    int? categoryId = await _categoriesStorage.add(category, storageErrors);

    if (storageErrors.hasAny())
    {
      if (storageErrors.isAlreadyExists())
      {
        errors.add(errors.ALREADY_EXISTS);
        return;
      }

      // Error handling is outdated.
      assert(false);
    }

    // Add to cache
    _categoriesCache.add(
      Category(
        id: categoryId!,
        name: category.name,
        isIncome: category.type == CategoryType.income,
        color: category.color.value
      )
    );
  }

  void _recreateCache() async
  {
    _categoriesCache = await _categoriesStorage.getAll();
  }

  /// Updates a category
  ///
  /// Nothing will be updated if error was encountered.
  Future<void> update(CategoryUpdateViewModel category, CategoryUpdateErrors errors) async
  {
    // Update in storage
    final storageErrors = CategoriesPersistentStorageUpdateErrors();
    _categoriesStorage.update(category, storageErrors);

    if (storageErrors.hasAny())
    {
      if (storageErrors.isAlreadyExists())
      {
        errors.add(errors.ALREADY_EXISTS);
        return;
      }

      // Error handling is outdated.
      assert(false);
    }

    // Update in cache
    for (Category categoryCached in _categoriesCache)
    {
      if (categoryCached.getId() == category.id)
      {
        categoryCached = Category(
          id: category.id,
          name: category.name,
          isIncome: category.type == CategoryType.income,
          color: category.color.value
        );
        return;
      }
    }
    // Cache is invalid
    _recreateCache();
  }

  /// Removes a category.
  ///
  /// Nothing will be deleted if error was encountered or category not exists.
  Future<void> remove(int id) async
  {
    _categoriesStorage.remove(id);

    // Remove from cache
    for (int i = 0; i < _categoriesCache.length; i++)
    {
      if (_categoriesCache[i].getId() == id)
      {
        _categoriesCache.removeAt(i);
        return;
      }
    }
    // Cache is invalid
    _recreateCache();
  }
}
