// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_money_5/UI/pages/categories/updating/category_updating_page.dart';
import '../creating/category_creating_page.dart';
import 'package:lab_money_5/repositories/category_repository/DTO/category_list_item.dart';
import 'package:lab_money_5/repositories/category_repository/category_repository.dart';
import 'package:lab_money_5/UI/pages/categories/listing/widgets/categories_list_widget.dart';
import 'package:lab_money_5/repositories/operation_repository/operation_repository.dart';

class CategoryListingPage extends StatefulWidget
{
  final CategoryRepository categories;
  final OperationRepository operations;

  const CategoryListingPage({super.key, required this.categories, required this.operations});

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

  void _updateCategoriesList()
  {
    setState(() {
      _categoriesList = widget.categories.getAll();
    });
  }

  void _gotoCategoryCreatingPage()
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryCreatingPage(
          categories: widget.categories,
          onCreate: _updateCategoriesList
        ),
      )
    );
  }

  void _gotoCategoryUpdatingPage(int id)
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryUpdatingPage(
          categories: widget.categories,
          onUpdate: _updateCategoriesList,
          categoryId: id,
        ),
      )
    );
  }

  void _removeCategory(int id) async
  {
    await widget.categories.remove(id);

    _updateCategoriesList();
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
            onPressed: _gotoCategoryCreatingPage,
          ),
        ],
      ),

      body: Expanded(
        child: CategoriesListWidget(
          categories: _categoriesList,
          removeCategory: _removeCategory,
          gotoCategoryUpdatingPage: _gotoCategoryUpdatingPage,
        ),
      ),
    );
  }
}
