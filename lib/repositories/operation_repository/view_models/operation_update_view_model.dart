/// A subsystem for passing data into procedure "update" of OperationRepository.
class OperationUpdateViewModel
{
  final int id;
  final int categoryId;
  final DateTime date;
  final double price;

  OperationUpdateViewModel({required this.id, required this.categoryId, required this.date, required this.price});
}
