// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_money_5/repositories/category_repository/DTO/category_list_item.dart';

/// A subsystem for displaying "List of categories" widget
/// of financial operations category listing page to the user.
class CategoriesListWidget extends StatelessWidget
{
  final List<CategoryListItem> categories;
  final void Function(int) removeCategory;

  const CategoriesListWidget({super.key, required this.categories, required this.removeCategory});

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
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index)
          {
            CategoryListItem category = categories[index];

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
                      onPressed: ()
                      {
                        removeCategory(category.getId());
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
