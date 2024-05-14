// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lab_money_5/UI/pages/categories/listing/category_listing_page.dart';
import 'package:lab_money_5/repositories/category_repository/category_repository.dart';
import 'package:lab_money_5/repositories/operation_repository/operation_repository.dart';
import 'package:lab_money_5/repositories/statistic_repository/statistic_repository.dart';

class MoneyApp extends StatefulWidget
{
  final CategoryRepository categories;
  final OperationRepository operations;
  final StatisticRepository statistics;

  const MoneyApp({super.key, required this.categories, required this.operations, required this.statistics});

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
          onSurface: Colors.black,
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
          children: [
            CategoryListingPage(categories: widget.categories),
            CategoryListingPage(categories: widget.categories),
            CategoryListingPage(categories: widget.categories),
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
  WidgetsFlutterBinding.ensureInitialized();
  final categories = CategoryRepository();
  final operations = OperationRepository();
  final statistics = StatisticRepository();
  await categories.init();
  await operations.init();
  await statistics.init();

  initializeDateFormatting('ru');

  MoneyApp app = MoneyApp(
    categories: categories,
    operations: operations,
    statistics: statistics,
  );
  runApp(app);
}
