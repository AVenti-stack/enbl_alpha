import 'package:flutter/material.dart';
import 'package:enbl_alpha/accountCreation/login_page.dart'; // Correct import
import 'package:enbl_alpha/globals.dart'; // Import the global function

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = "Guest"; // Default value is "Guest"
  int _selectedIndex = 4;

  @override
  void initState() {
    super.initState();
    _initializeFirstName(); // Load the user's first name when the page is initialized
  }

  // Function to load the first name using the global function
  Future<void> _initializeFirstName() async {
    String name = await loadFirstName(); // Call the global function from globals.dart
    setState(() {
      firstName = name; // Update the state with the loaded first name
    });
  }

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
              // Greeting Text and Profile Image Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
<<<<<<< HEAD
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
=======
                  Text(
                    "HI $firstName,", // Use the dynamically loaded first name
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: customGreen,
              
                    ),
                  ),
                  // Profile Image
>>>>>>> 03155d1c3d06bf5b39e29ae18386a170daeabe2c
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
              const SizedBox(height: 50),
              
              // Left-side Column with icons and text on the right side
              const Column(
                children: [
                  // Heart Icon and "temp" text on the right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.favorite, size: 40, color: customGreen), // Heart
                      Text("Saved Recipes", style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Dumbbell Icon and "temp" text on the right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.fitness_center, size: 40, color: customGreen), // Dumbbell
                      Text("Saved Workouts", style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Envelope Icon and "temp" text on the right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.email, size: 40, color: customGreen), // Envelope
                      Text("Email", style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Ruler Icon and "temp" text on the right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.straighten, size: 40, color: customGreen), // Ruler
                      Text("Height", style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Scale Icon and "temp" text on the right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.monitor_weight, size: 40, color: customGreen), // Scale
                      Text("Weigt", style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Paper Icon and "temp" text on the right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.description, size: 40, color: customGreen), // Paper with folded corner
                      Text("Dietary Restructions", style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Clock Icon and "temp" text on the right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.timer, size: 40, color: customGreen), // Clock
                      Text("Age", style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Clock Icon and "temp" text on the right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.sports, size: 40, color: customGreen), // Clock
                      Text("Equipment", style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ],
              ),

              const Spacer(), // Push everything above the treadmill icon

              // Row with Treadmill Icon as the logout button and label
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Align everything to the right
                children: [
                  const Text("Logout", style: TextStyle(fontSize: 10, color: Colors.black)),
                  const SizedBox(width: 5), // Space between text and the icon
                  IconButton(
                    icon: const Icon(Icons.directions_run, size: 40, color: Colors.black), // Treadmill icon
                    onPressed: () {
                      // Log out and navigate to the LoginPage when the treadmill icon is clicked
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
