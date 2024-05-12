// ignore_for_file: curly_braces_in_flow_control_structures

import 'DTO/operation.dart';
import 'DTO/operation_list_item.dart';
import 'errors/operation_add_errors.dart';
import 'errors/operation_update_errors.dart';
import 'view_models/operation_add_view_model.dart';
import 'view_models/operation_update_view_model.dart';

/// A subsystem for interacting with stored data on user's financial operations.
class OperationRepository
{
  /// Initializes [CategoryRepository] object
  Future<void> init() async
  {
    // 1. Initialize persistent storage
    // 2. Initialize in-memory cache
  }

  /// Retrieves all existing user's financial operations
  ///
  /// Returns an empty list if error was encountered.
  List<OperationListItem> getAll()
  {
    // 1. Get from in-memory cache
  }

  /// Retrieves user's financial operation's data
  ///
  /// Returns `null` if error occurred or financial operation not exists.
  Operation? get(int id)
  {
    // 1. Get from in-memory cache
  }

  /// Adds a new financial operation for user.
  ///
  /// Nothing will be added if error was encountered.
  Future<void> add(OperationAddViewModel operation, OperationAddErrors errors) async
  {
    // 1. Try add to persistent storage
    // 2. Add to in-memory cache
  }

  /// Updates user's financial operation
  ///
  /// Nothing will be updated if error was encountered.
  Future<void> update(OperationUpdateViewModel operation, OperationUpdateErrors errors) async
  {
    // 1. Try update in persistent storage
    // 2. Update in-memory cache
  }

  /// Removes user's financial operation
  ///
  /// Nothing will be deleted if error was encountered or category not exists.
  Future<void> remove(int id) async
  {
    // 1. Try remove from persistent storage
    // 2. Remove from in-memory cache
  }
}
