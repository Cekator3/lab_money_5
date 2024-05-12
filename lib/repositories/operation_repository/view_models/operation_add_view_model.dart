/// A subsystem for passing data into procedure "add" of OperationRepository.
class OperationAddViewModel
{
  final int categoryId;
  final DateTime date;
  final double price;

  OperationAddViewModel({required this.categoryId, required this.date, required this.price});
}
