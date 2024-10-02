import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:enbl_alpha/accountCreation/account_creation.dart';
import 'package:enbl_alpha/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Set the hardcoded path for the login data JSON file
  final String _jsonDirectoryPath = '/Users/giangnguyen/Desktop/enbl_alpha/JSON_files';

  // Get the path for the login data JSON
  Future<String> _getLoginJsonFilePath() async {
    final jsonFolder = Directory(_jsonDirectoryPath);
    if (!(await jsonFolder.exists())) {
      await jsonFolder.create(recursive: true); // Create the folder if it doesn't exist
    }
    return '${jsonFolder.path}/login_data.json'; // Path for login info JSON
  }

  // Function to check login credentials
  Future<void> _login() async {
    // Get file path for login data
    final filePath = await _getLoginJsonFilePath();
    final file = File(filePath);

    if (await file.exists()) {
      // Read the content of the login_data.json file
      String fileContent = await file.readAsString();
      Map<String, dynamic> loginData = jsonDecode(fileContent);

      // Get the email and password from the form, and convert email to lowercase
      String email = _emailController.text.toLowerCase();
      String password = _passwordController.text;

      // Check if the email exists in the JSON file (case-insensitive)
      if (loginData.containsKey(email)) {
        // If email exists, check if the password matches
        if (loginData[email]['password'] == password) {
          // Successful login: Navigate to the MainScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()), // Navigate to MainScreen
          );
        } else {
          // Show error message if password doesn't match
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect password. Please try again.')),
          );
        }
      } else {
        // Show error message if email is not found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email not found. Please create an account.')),
        );
      }
    } else {
      // If login_data.json doesn't exist, prompt the user to create an account
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user data found. Please create an account.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,  // Call the login function
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the CreateAccountPage if the user needs to create an account
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateAccountPage()),
                );
              },
              child: const Text('No account? Create one'),
            ),
          ],
        ),
      ),
    );
  }
}
