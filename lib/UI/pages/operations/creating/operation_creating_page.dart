
// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:lab_money_5/repositories/category_repository/category_repository.dart';
import 'package:lab_money_5/repositories/operation_repository/operation_repository.dart';
import 'package:lab_money_5/repositories/category_repository/DTO/category_list_item.dart';
import 'package:lab_money_5/repositories/operation_repository/view_models/operation_add_view_model.dart';

class OperationCreatingPage extends StatefulWidget
{
  final CategoryRepository categories;
  final OperationRepository operations;
  final void Function() onCreate;

  const OperationCreatingPage({super.key, required this.categories, required this.operations, required this.onCreate});

  @override
  State<OperationCreatingPage> createState() => OperationCreatingPageState();
}

class OperationCreatingPageState extends State<OperationCreatingPage>
{
  final _formKey = GlobalKey<FormState>();
  List<CategoryListItem> _categoriesList = [];
  CategoryListItem? _category;
  DateTime _date = DateTime.now();
  double _price = 0.0;

  @override
  void initState()
  {
    super.initState();

    _categoriesList = widget.categories.getAll();
    _category = _categoriesList.first;
  }

  List<DropdownMenuItem<CategoryListItem>> _getCategories()
  {
    return _categoriesList.map((CategoryListItem category)
    {
      return DropdownMenuItem<CategoryListItem>(
        value: category,
        child: Text(
          category.getName(),
          style: TextStyle(
            color: category.getColor(),
          ),
        ),
      );
    }).toList();
  }

  void _createOperation() async
  {
    final operation = OperationAddViewModel(categoryId: _category!.getId(), date: _date, price: _price);
    await widget.operations.add(operation);
    widget.onCreate();
    Navigator.pop(context);
  }

  Future<DateTime?> _negotiateDate() async
  {
    return await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая финансовая операция'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: const Text('Дата'),
                subtitle: Text(DateFormat.yMMMMd('ru').format(_date)),
                onTap: () async
                {
                  final date = await _negotiateDate();
                  if (date == null || date == _date)
                    return;

                  setState(() {
                    _date = date;
                  });
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: _category,
                items: _getCategories(),
                onChanged: (CategoryListItem? category)
                {
                  if (category == null)
                    return;

                  setState(() {
                    _category = category;
                  });
                },

                decoration: const InputDecoration(
                  labelText: 'Категория',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Сумма',
                  border: OutlineInputBorder()
                ),
                validator: (value)
                {
                  if (value == null || value.isEmpty)
                    return 'Введите сумму';
                  return null;
                },
                onChanged: (value)
                {
                  _price = double.tryParse(value) ?? 0.0;
                },
              ),

              ElevatedButton(
                onPressed: _createOperation,
                child: const Text('Сохранить изменения'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
