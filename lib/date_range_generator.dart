import 'package:flutter/material.dart';

/// Subsystem for generating date time range
class DateRangeGenerator
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

  static DateTimeRange thisDay()
  {
    return DateTimeRange(start: _startOfToday(), end: _endOfToday());
  }

  static DateTime _startOfThisWeek()
  {
    return _today.subtract(Duration(days: _today.weekday - 1));
  }

  static DateTime _endOfThisWeek()
  {
    return _today.add(Duration(days: DateTime.daysPerWeek - _today.weekday));
  }

  static DateTimeRange thisWeek()
  {
    return DateTimeRange(start: _startOfThisWeek(), end: _endOfThisWeek());
  }

  static DateTime _startOfThisMonth()
  {
    return DateTime(_today.year, _today.month, 1);
  }

  static DateTime _endOfThisMonth()
  {
    return DateTime(_today.year, _today.month + 1, 0);
  }

  static DateTimeRange thisMonth()
  {
    return DateTimeRange(start: _startOfThisMonth(), end: _endOfThisMonth());
  }

  static DateTime _startOfThisYear()
  {
    return DateTime(_today.year, 1, 1);
  }

  static DateTime _endOfThisYear()
  {
    return DateTime(_today.year, 12, 31, 23, 59, 59, 999, 999);
  }

  static DateTimeRange thisYear()
  {
    return DateTimeRange(start: _startOfThisYear(), end: _endOfThisYear());
  }
}
