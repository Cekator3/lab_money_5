// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_money_5/repositories/category_repository/category_repository.dart';
import 'package:lab_money_5/repositories/operation_repository/operation_repository.dart';
import 'package:lab_money_5/repositories/category_repository/DTO/category_list_item.dart';

/// A subsystem for displaying "List of categories" widget
/// of financial operations category listing page to the user.
class CategoriesListWidget extends StatefulWidget
{
  final CategoryRepository categories;
  final OperationRepository operations;

  const CategoriesListWidget({super.key, required this.categories, required this.operations});

  @override
  CategoriesListWidgetState createState() => CategoriesListWidgetState();
}

class CategoriesListWidgetState extends State<CategoriesListWidget>
{
  List<CategoryListItem> _categoriesList = [];

  @override
  void initState()
  {
    super.initState();

    _categoriesList = widget.categories.getAll();
  }

  Future<bool> isUserWantsToRemoveCategory(BuildContext context) async
  {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Удалить?'),
          content: const Text('Все операции этой категории будут удалены. Продолжить?'),
          actions: [
            TextButton(
              onPressed: ()
              {
                Navigator.of(context).pop(true);
              },
              child: const Text('Да'),
            ),
            TextButton(
              onPressed: ()
              {
                Navigator.of(context).pop(false);
              },
              child: const Text('Нет'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  void removeCategory(int id) async
  {
    await widget.categories.remove(id);
    widget.operations.removeAllByCategory(id);

    setState(()
    {
      _categoriesList = widget.categories.getAll();
    });
  }

  void tryRemoveCategory(int id, BuildContext context) async
  {
    if (await isUserWantsToRemoveCategory(context))
      removeCategory(id);
  }

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
          itemCount: _categoriesList.length,
          itemBuilder: (BuildContext context, int index)
          {
            CategoryListItem category = _categoriesList[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: Text(
                  category.getName(),
                  style: TextStyle(color: category.getColor()),
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: category.getColor(),
                      onPressed: () {},
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: category.getColor(),
                      onPressed: () async
                      {
                        tryRemoveCategory(category.getId(), context);
                      },
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
