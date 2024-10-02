import 'package:flutter/material.dart';
import 'package:enbl_alpha/fitnesspage/fitness_page.dart';
import 'package:enbl_alpha/homepage/main_food_page.dart';
import 'package:enbl_alpha/nutritionpage/nutrition_page.dart';
import 'package:enbl_alpha/profilepage/profile_page.dart';
import 'package:enbl_alpha/searchpage/search_page.dart';
import 'package:enbl_alpha/accountCreation/account_creation.dart'; // Update this to the correct path
import 'package:enbl_alpha/accountCreation/login_page.dart'; // Correct path for account creation

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
      home: const LoginPage(), // Show the LoginPage when the app starts
    );
  }
}

// MainScreen with Bottom Navigation Bar
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of pages for the BottomNavigationBar
  static final List<Widget> _pages = <Widget>[
    MainFoodPage(),
    FitnessPage(),
    SearchPage(),
    NutritionPage(),
    ProfilePage(),
  ];

  // Function to handle taps on the BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
