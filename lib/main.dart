// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
}
