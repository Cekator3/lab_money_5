import 'package:flutter/material.dart';
import 'package:lab_money_5/repositories/category_repository/DTO/category_list_item.dart';
import 'package:lab_money_5/repositories/category_repository/category_repository.dart';

/// A subsystem for displaying "List of news" widget of "news" page to the user.
class CategoriesListWidget extends StatelessWidget
{
  final CategoryRepository categories;
  final List<CategoryListItem> categoriesList;

  const CategoriesListWidget({super.key, required this.categories, required this.categoriesList});

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
          itemCount: categoriesList.length,
          itemBuilder: (BuildContext context, int index)
          {
            CategoryListItem category = categoriesList[index];

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
                      onPressed: () {},
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
