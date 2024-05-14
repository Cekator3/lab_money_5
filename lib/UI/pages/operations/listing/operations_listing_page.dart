// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_money_5/UI/pages/operations/creating/operation_creating_page.dart';
import 'package:lab_money_5/UI/pages/operations/updating/operation_updating_page.dart';
import 'package:lab_money_5/repositories/category_repository/category_repository.dart';
import 'package:lab_money_5/repositories/operation_repository/operation_repository.dart';
import 'package:lab_money_5/repositories/operation_repository/DTO/operation_list_item.dart';

import 'widgets/operations_list_widget.dart';

class OperationsListingPage extends StatefulWidget
{
  final OperationRepository operations;
  final CategoryRepository categories;

  const OperationsListingPage({super.key, required this.operations, required this.categories});

  @override
  OperationsListingPageState createState() => OperationsListingPageState();
}

class OperationsListingPageState extends State<OperationsListingPage>
{
  List<OperationListItem> _operationsList = [];

  @override
  void initState()
  {
    super.initState();
    () async
    {
      _operationsList = await widget.operations.getAll();
    } ();
  }

  void _updateOperationsList() async
  {
    final operations = await widget.operations.getAll();
    setState(() {
        _operationsList = operations;
    });
  }

  void _gotoOperationCreatingPage()
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OperationCreatingPage(
          operations: widget.operations,
          categories: widget.categories,
          onCreate: _updateOperationsList
        ),
      )
    );
  }

  void _gotoOperationUpdatingPage(int id)
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OperationUpdatingPage(
          categories: widget.categories,
          operations: widget.operations,
          operationId: id,
          onUpdate: _updateOperationsList,
        ),
      )
    );
  }

  void _removeOperation(int id) async
  {
    await widget.operations.remove(id);

    _updateOperationsList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Финансовые операции'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: _gotoOperationCreatingPage,
          ),
        ],
      ),

      body: Expanded(
        child: OperationsListWidget(
          operations: _operationsList,
          removeOperation: _removeOperation,
          gotoOperationUpdatingPage: _gotoOperationUpdatingPage,
        ),
      )
    );
  }
}
