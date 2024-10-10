// lib/globals.dart

import 'package:flutter/material.dart';  // Import the Flutter package for Color

// Global constants
// lib/globals.dart
String userKey = "";  // Global variable to hold the user's email or username

const Color customGreen = Color(0xFF48A14F);

final Image workoutexample = Image.asset('assets/image/WomanDoingShoulders.jpeg');
final Image foodExample = Image.asset('assets/image/ChickenBreast.jpg');

Future<String> loadFirstName() async {
  String firstName = "John"; // Example first name
  return firstName.toUpperCase(); // Return the first name in uppercase
}


