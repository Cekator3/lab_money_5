// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
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
          CategoriesListWidget(categories: widget.categories, operations: widget.operations),
        ],
      )
    );
  }
}
