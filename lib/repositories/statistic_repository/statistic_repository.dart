/// A subsystem for reading stored statistical data on user's financial operations.
class StatisticRepository
{
  /// Initializes [StatisticRepository] object
  Future<void> init() async
  {
    // ...
  }

  /// Retrieves statistical data on a user's financial operations.
  ///
  /// Returns an empty list if error was encountered.
  Future<List<StatisticEntry>> get(StatisticGetViewModel search) async
  {
    // ...
  }
}
