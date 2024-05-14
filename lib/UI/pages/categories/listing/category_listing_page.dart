// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_money_5/UI/pages/categories/listing/widgets/categories_list.dart';
import 'package:lab_money_5/repositories/category_repository/DTO/category_list_item.dart';
import 'package:lab_money_5/repositories/category_repository/category_repository.dart';

class CategoryListingPage extends StatefulWidget
{
  final CategoryRepository categories;

  const CategoryListingPage({super.key, required this.categories});

  @override
  CategoryListingPageState createState() => CategoryListingPageState();
}

class CategoryListingPageState extends State<CategoryListingPage>
{
  List<CategoryListItem> _categoriesList = [];

  @override
  void initState()
  {
    super.initState();
    _categoriesList = widget.categories.getAll();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          CategoriesListWidget(categories: widget.categories, categoriesList: _categoriesList)
        ],
      )
    );
  }
}
