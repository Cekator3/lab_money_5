// ignore_for_file: non_constant_identifier_names

import 'package:lab_money_5/errors.dart';

/// A subsystem for reading errors
/// that may occur during an attempt
/// to add a new financial operation.
class OperationAddErrors extends Errors
{
  final int PRICE_MUST_BE_POSITIVE = 1;

  /// Checks if ocurred an error because price is not positive (price <= 0)
  bool isPriceMustBePositive()
  {
    return has(PRICE_MUST_BE_POSITIVE);
  }
}
