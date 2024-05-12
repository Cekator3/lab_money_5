// ignore_for_file: non_constant_identifier_names

import 'package:lab_money_5/errors.dart';

/// A subsystem for reading errors
/// that may occur during an attempt
/// to update user's financial operation.
class OperationUpdateErrors extends Errors
{
  final int PRICE_IS_ZERO_OR_NEGATIVE = 1;

  /// Checks if ocurred an error because operation's price is zero or negative
  bool isZeroOrNegative()
  {
    return has(PRICE_IS_ZERO_OR_NEGATIVE);
  }
}
