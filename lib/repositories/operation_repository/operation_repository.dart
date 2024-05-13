// ignore_for_file: curly_braces_in_flow_control_structures

import 'DTO/operation.dart';
import 'DTO/operation_list_item.dart';
import 'view_models/operation_add_view_model.dart';
import 'view_models/operation_update_view_model.dart';
import 'package:lab_money_5/repositories/operation_repository/operations_persistent_storage/operations_persistent_storage.dart';

/// A subsystem for interacting with stored data on user's financial operations.
class OperationRepository
{
  List<Operation> _operationsCache = [];
  final _operationStorage = OperationsPersistentStorage();


  /// Initializes [CategoryRepository] object
  Future<void> init() async
  {
    await _operationStorage.init();
    _operationsCache = await _operationStorage.getAll();
  }

  /// Retrieves all existing user's financial operations
  ///
  /// Returns an empty list if error was encountered.
  List<OperationListItem> getAll()
  {
    // 1. Get from cache
    return _operationsCache.map((operation) =>
      OperationListItem(
        id: operation.getId(),
        category: operation.getCategory(),
        date: operation.getDate().millisecondsSinceEpoch,
        price: operation.getPrice()
      )
    ).toList();
  }

  /// Retrieves user's financial operation's data
  ///
  /// Returns `null` if error occurred or financial operation not exists.
  Operation? get(int id)
  {
    // 1. Get from cache
    for (Operation operation in _operationsCache)
      if (operation.getId() == id)
        return operation;
    return null;
  }

  /// Adds a new financial operation for user.
  ///
  /// Nothing will be added if error was encountered.
  Future<void> add(OperationAddViewModel operation) async
  {
    // 1. Try add to persistent storage
    int? operationId = await _operationStorage.add(operation);
    // 2. Add to cache
    _operationsCache.add((await _operationStorage.get(operationId!))!);
  }

  void _recreateCache() async
  {
    _operationsCache = await _operationStorage.getAll();
  }

  /// Updates user's financial operation
  ///
  /// Nothing will be updated if error was encountered.
  Future<void> update(OperationUpdateViewModel operation) async
  {
    // 1. Try update in persistent storage
    await _operationStorage.update(operation);
    // 2. Update cache
    for (int i = 0; i < _operationsCache.length; i++)
    {
      if (_operationsCache[i].getId() == operation.id)
      {
        _operationsCache[i] = (await _operationStorage.get(operation.id))!;
        return;
      }
    }
    // Cache is invalid
    _recreateCache();
  }

  /// Removes user's financial operation
  ///
  /// Nothing will be deleted if error was encountered or operation not exists.
  Future<void> remove(int id) async
  {
    // 1. Try remove from persistent storage
    _operationStorage.remove(id);

    // 2. Remove from in-memory cache
    for (int i = 0; i < _operationsCache.length; i++)
    {
      if (_operationsCache[i].getId() == id)
      {
        _operationsCache.removeAt(i);
        return;
      }
    }
    // Cache is invalid
    _recreateCache();
  }

  /// Removes user's financial operations associated with certain category
  ///
  /// Nothing will be deleted if error was encountered.
  Future<void> removeAllByCategory(int categoryId) async
  {
    // 1. Remove from in-memory cache
    _operationsCache.removeWhere((operation) => operation.getCategory().getId() == categoryId);
  }
}
