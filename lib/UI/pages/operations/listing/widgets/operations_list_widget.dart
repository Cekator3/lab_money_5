// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_money_5/repositories/operation_repository/DTO/operation_list_item.dart';

/// A subsystem for displaying "List of categories" widget
/// of financial operations category listing page to the user.
class OperationsListWidget extends StatelessWidget
{
  final List<OperationListItem> operations;
  final void Function(int) removeOperation;
  final void Function(int) gotoOperationUpdatingPage;

  const OperationsListWidget({super.key, required this.operations, required this.removeOperation, required this.gotoOperationUpdatingPage});

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0)
        ),
        padding: const EdgeInsets.only(left: 16.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: operations.length,
          itemBuilder: (BuildContext context, int index)
          {
            OperationListItem operation = operations[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: Text(
                  operation.getCategory().getName(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMMd('ru').format(operation.getDate())),
                    Text('${operation.getPrice()} ₽')
                  ],
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => gotoOperationUpdatingPage(operation.getId()),
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => removeOperation(operation.getId()),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
