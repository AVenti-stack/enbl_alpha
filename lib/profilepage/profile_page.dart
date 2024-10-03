import 'package:flutter/material.dart';
import 'package:enbl_alpha/accountCreation/login_page.dart'; // Correct import

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hi John,",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  // Replace green circle with image
                  ClipOval( // Clip the image to a circular shape
                    child: Image.asset(
                      'assets/image/GymBroProfile.jpg', // Use the correct path
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover, // Ensures the image covers the circle
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Other profile content can go here

              // Logout button
              const Spacer(), // Pushes the button to the bottom
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Log out and navigate to the LoginPage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Red color for logout
                  ),
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
