import 'package:enbl_alpha/globals.dart';
import 'package:flutter/material.dart';
import 'package:enbl_alpha/fitnesspage/fitness_page.dart';
import 'package:enbl_alpha/homepage/main_food_page.dart';
import 'package:enbl_alpha/nutritionpage/nutrition_page.dart';
import 'package:enbl_alpha/profilepage/profile_page.dart';
import 'package:enbl_alpha/searchpage/search_page.dart';
import 'package:enbl_alpha/accountCreation/login_page.dart'; // Correct path for account creation
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Set the text theme to use Barlow font across the entire app
        textTheme: GoogleFonts.barlowTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // Show the LoginPage when the app starts
    );
  }
}

// MainScreen with Bottom Navigation Bar
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of pages for the BottomNavigationBar
  static final List<Widget> _pages = <Widget>[
    const MainFoodPage(),
    const FitnessPage(),
    const SearchPage(),
    const NutritionPage(),
    const ProfilePage(),
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
            icon: Icon(Icons.chat_bubble),
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
        selectedItemColor: customGreen,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
