import 'date_interval.dart';

/// Subsystem for generating time intervals
class DateIntervalGenerator
{
  static final _today = DateTime.now();

  static DateTime _startOfToday()
  {
    return DateTime(_today.year, _today.month, _today.day);
  }

  static DateTime _endOfToday()
  {
    return DateTime(_today.year, _today.month, _today.day, 23, 59, 59, 59, 59);
  }

  static DateInterval thisDay()
  {
    return DateInterval(_startOfToday(), _endOfToday());
  }

  static DateTime _startOfThisWeek()
  {
    return _today.subtract(Duration(days: _today.weekday - 1));
  }

  static DateTime _endOfThisWeek()
  {
    return _today.add(Duration(days: DateTime.daysPerWeek - _today.weekday));
  }

  static DateInterval thisWeek()
  {
    return DateInterval(_startOfThisWeek(), _endOfThisWeek());
  }

  static DateTime _startOfThisMonth()
  {
    return DateTime(_today.year, _today.month, 1);
  }

  static DateTime _endOfThisMonth()
  {
    return DateTime(_today.year, _today.month + 1, 0);
  }

  static DateInterval thisMonth()
  {
    return DateInterval(_startOfThisMonth(), _endOfThisMonth());
  }

  static DateTime _startOfThisYear()
  {
    return DateTime(_today.year, 1, 1);
  }

  static DateTime _endOfThisYear()
  {
    return DateTime(_today.year, 12, 31, 23, 59, 59, 999, 999);
  }

  static DateInterval thisYear()
  {
    return DateInterval(_startOfThisYear(), _endOfThisYear());
  }
}
