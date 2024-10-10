import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:enbl_alpha/accountCreation/account_creation.dart';
import 'package:enbl_alpha/main.dart';
import 'package:enbl_alpha/globals.dart';  // Import the global variable

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _jsonDirectoryPath = '/Users/giangnguyen/Desktop/enbl_alpha/JSON_files';

  Future<String> _getLoginJsonFilePath() async {
    final jsonFolder = Directory(_jsonDirectoryPath);
    if (!(await jsonFolder.exists())) {
      await jsonFolder.create(recursive: true);
    }
    return '${jsonFolder.path}/login_data.json';
  }

  Future<void> _login() async {
    final filePath = await _getLoginJsonFilePath();
    final file = File(filePath);

    if (await file.exists()) {
      String fileContent = await file.readAsString();
      Map<String, dynamic> loginData = jsonDecode(fileContent);

      String email = _emailController.text.toLowerCase();
      String password = _passwordController.text;

      if (loginData.containsKey(email)) {
        if (loginData[email]['password'] == password) {
          // Update the global variable with the user's email or username
          setState(() {
            userKey = email;  // Update userKey when login is successful
            print('Global userKey has been updated to: $userKey');  // Print the updated userKey
          });

          // Navigate to the MainScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else {
          // Incorrect password
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect password. Please try again.')),
          );
        }
      } else {
        // Email not found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email not found. Please create an account.')),
        );
      }
    } else {
      // No user data found
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
                // Navigate to the CreateAccountPage
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
