import 'package:lab_money_5/enums/category_type.dart';

/// Subsystem to translate [CategoryType] values into user-readable text.
class CategoryTypeLocalization
{
  static final _localizations = {
    CategoryType.income: 'Доход',
    CategoryType.loss: 'Убыток',
  };

  static String localize(CategoryType type)
  {
    return _localizations[type]!;
  }
}
