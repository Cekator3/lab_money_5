/// Subsystem that stores the time interval
class DateInterval
{
  final DateTime _start;
  final DateTime _end;

  DateInterval(this._start, this._end);

  DateTime start() => _start;
  DateTime end() => _end;
}
