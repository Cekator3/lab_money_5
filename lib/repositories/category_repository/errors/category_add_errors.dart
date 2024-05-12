// ignore_for_file: non_constant_identifier_names

import 'package:lab_money_5/errors.dart';

/// A subsystem for reading errors
/// that may occur during an attempt
/// to add a new category.
class CategoryAddErrors extends Errors
{
  final int ALREADY_EXISTS = 1;

  /// Checks if ocurred an error because category isn't unique.
  bool isAlreadyExists()
  {
    return has(ALREADY_EXISTS);
  }
}
