// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_money_5/repositories/category_repository/categories_persistent_storage/categories_persistent_storage.dart';
import 'package:lab_money_5/repositories/category_repository/categories_persistent_storage/errors/categories_persistent_storage_add_errors.dart';
import 'package:lab_money_5/repositories/category_repository/category_repository.dart';
import 'package:lab_money_5/repositories/category_repository/enums/category_type.dart';
import 'package:lab_money_5/repositories/category_repository/errors/category_add_errors.dart';
import 'package:lab_money_5/repositories/category_repository/view_models/category_add_view_model.dart';
import 'package:lab_money_5/repositories/operation_repository/operation_repository.dart';
import 'package:lab_money_5/repositories/operation_repository/operations_persistent_storage/operations_persistent_storage.dart';
import 'package:lab_money_5/repositories/operation_repository/view_models/operation_add_view_model.dart';

class MoneyApp extends StatefulWidget
{
  const MoneyApp({super.key});

  @override
  MoneyAppState createState() => MoneyAppState();
}

class MoneyAppState extends State<MoneyApp>
{
  int currentIndex = 0;

  @override
  Widget build(BuildContext context)
  {
    void onNavigationBarLinkTapped(int index) async
    {
      setState(() {
        currentIndex = index;
      });
    }

    return MaterialApp(
        title: 'Финансовый журнал',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.light(
                onSurface: Colors.white,
                onBackground: Colors.cyan,
            ),
            textTheme: GoogleFonts.manropeTextTheme(
              const TextTheme(
                bodyMedium: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                bodySmall: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                bodyLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                )
              )
            ),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.cyan,
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                ),
                centerTitle: true,
            ),
        ),
        home: Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: const [
              // PlacesPage(),
              // FavoritePlacesPage()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onNavigationBarLinkTapped,
            selectedItemColor: Colors.cyan,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Статистика',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.money),
                label: 'Операции',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Категории',
              ),
            ],
          ),
        )
    );
  }
}

void main() async
{
  MoneyApp app = const MoneyApp();
  runApp(app);

  final categories = CategoryRepository();
  await categories.init();
  await categories.add(CategoryAddViewModel(name: 'lol2', type: CategoryType.income, color: Colors.black), CategoryAddErrors());
  await categories.add(CategoryAddViewModel(name: 'lol1', type: CategoryType.income, color: Colors.black), CategoryAddErrors());
  await categories.add(CategoryAddViewModel(name: 'lol3', type: CategoryType.income, color: Colors.black), CategoryAddErrors());

  final operations = OperationRepository();
  await operations.init();
  final res1 = categories.getAll();
  await operations.add(OperationAddViewModel(categoryId: res1.first.getId(), date: DateTime.now(), price: 123));
  await operations.add(OperationAddViewModel(categoryId: res1.first.getId(), date: DateTime.now(), price: 456));
  await operations.add(OperationAddViewModel(categoryId: res1.first.getId(), date: DateTime.now(), price: 789));
  final res2 = operations.getAll();
  final categoryId = res1.first.getId();
  await categories.remove(categoryId);
  await operations.removeAllByCategory(categoryId);
  final res3 = operations.getAll();
}
