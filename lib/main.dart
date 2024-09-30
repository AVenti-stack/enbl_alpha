import 'package:flutter/material.dart';
import 'package:enbl_alpha/fitnesspage/fitness_page.dart';
import 'package:enbl_alpha/homepage/main_food_page.dart';
import 'package:enbl_alpha/nutritionpage/nutrition_page.dart';
import 'package:enbl_alpha/profilepage/profile_page.dart';
import 'package:enbl_alpha/searchpage/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of pages for navigation
  static final List<Widget> _pages = <Widget>[
    MainFoodPage(),      // Your MainFoodPage
    FitnessPage(),       // Your FitnessPage
    SearchPage(),        // Your SearchPage
    NutritionPage(),     // Your NutritionPage
    ProfilePage(),       // Your ProfilePage
  ];

  // Handle tap on bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the index to switch pages
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page

      // Custom Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Fitness',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apple),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green,     // Set the color of the selected item
        unselectedItemColor: Colors.grey,    // Set the color of the unselected items
      ),
    );
  }
}
