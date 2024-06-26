// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:lab_money_5/repositories/operation_repository/errors/operation_add_errors.dart';
import 'package:lab_money_5/repositories/operation_repository/errors/operation_update_errors.dart';

import 'DTO/operation.dart';
import 'DTO/operation_list_item.dart';
import 'view_models/operation_add_view_model.dart';
import 'view_models/operation_update_view_model.dart';
import 'operations_persistent_storage/operations_persistent_storage.dart';

/// A subsystem for interacting with stored data on user's financial operations.
class OperationRepository
{
  final _operationStorage = OperationsPersistentStorage();

  /// Initializes [CategoryRepository] object
  Future<void> init() async
  {
    await _operationStorage.init();
  }

  /// Retrieves all existing user's financial operations
  ///
  /// Returns an empty list if error was encountered.
  Future<List<OperationListItem>> getAll() async
  {
    return await _operationStorage.getAll();
  }

  /// Retrieves user's financial operation's data
  ///
  /// Returns `null` if error occurred or financial operation not exists.
  Future<Operation?> get(int id) async
  {
    return await _operationStorage.get(id);
  }

  void _validatePrice(double price, dynamic errors)
  {
    if (price <= 0.0)
      errors.add(errors.PRICE_MUST_BE_POSITIVE);
  }

  /// Adds a new financial operation for user.
  ///
  /// Nothing will be added if error was encountered.
  Future<void> add(OperationAddViewModel operation, OperationAddErrors errors) async
  {
    _validatePrice(operation.price, errors);
    if (errors.hasAny())
      return;
    await _operationStorage.add(operation);
  }

  /// Updates user's financial operation
  ///
  /// Nothing will be updated if error was encountered.
  Future<void> update(OperationUpdateViewModel operation, OperationUpdateErrors errors) async
  {
    _validatePrice(operation.price, errors);
    if (errors.hasAny())
      return;
    await _operationStorage.update(operation);
  }

  /// Removes user's financial operation
  ///
  /// Nothing will be deleted if error was encountered or operation not exists.
  Future<void> remove(int id) async
  {
    await _operationStorage.remove(id);
  }
}
