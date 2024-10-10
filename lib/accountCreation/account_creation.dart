import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:enbl_alpha/main.dart'; // Import MainScreen for navigation after account creation

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  // Feet and inches values for height
  int selectedFeet = 5; // Default selected feet
  int selectedInches = 6; // Default selected inches

  DateTime? _selectedBirthday;
  int? _calculatedAge;

  String? selectedFoodPreference;
  String? selectedBodyGoals;
  String? selectedAllergies;
  String? selectedWorkoutFrequency;
  String? selectedWorkoutExperience;

  bool _isFormComplete = false;
  bool _emailAlreadyInUse = false;

  final PageController _pageController = PageController();

  // Path to the desired folder
  final String _jsonDirectoryPath = '/Users/giangnguyen/Desktop/enbl_alpha/JSON_files';

  @override
  void initState() {
    super.initState();

    // Listen for changes in text fields to check form completeness
    _emailController.addListener(_checkFormComplete);
    _passwordController.addListener(_checkFormComplete);
    _firstNameController.addListener(_checkFormComplete);
    _lastNameController.addListener(_checkFormComplete);
  }

  // Function to get the file path for user data
  Future<String> _getUserJsonFilePath() async {
    final jsonFolder = Directory(_jsonDirectoryPath);
    if (!(await jsonFolder.exists())) {
      await jsonFolder.create(recursive: true); // Create the folder if it doesn't exist
    }

    return '${jsonFolder.path}/user_data.json'; // JSON file for user info
  }

  // Function to get the file path for login data (email and password)
  Future<String> _getLoginJsonFilePath() async {
    final jsonFolder = Directory(_jsonDirectoryPath);
    if (!(await jsonFolder.exists())) {
      await jsonFolder.create(recursive: true); // Create the folder if it doesn't exist
    }

    return '${jsonFolder.path}/login_data.json'; // JSON file for login info
  }

  // Function to check if the email is already in use
  Future<bool> _isEmailInUse(String email) async {
    final filePath = await _getLoginJsonFilePath();
    final file = File(filePath);

    if (await file.exists()) {
      String fileContent = await file.readAsString();
      Map<String, dynamic> loginData = jsonDecode(fileContent);

      // Check if the email exists in the data (case-insensitive)
      return loginData.containsKey(email.toLowerCase());
    }
    return false;
  }

  // Function to check if the form is complete
  void _checkFormComplete() {
    setState(() {
      _isFormComplete = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _selectedBirthday != null;
    });
  }

  // Function to open the birthday picker and calculate age
  void _selectBirthday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // Default date
      firstDate: DateTime(1900), // Minimum date
      lastDate: DateTime.now(), // Maximum date (today)
    );
    if (picked != null && picked != _selectedBirthday) {
      setState(() {
        _selectedBirthday = picked;
        _calculatedAge = DateTime.now().year - picked.year;
        if (DateTime.now().month < picked.month ||
            (DateTime.now().month == picked.month && DateTime.now().day < picked.day)) {
          _calculatedAge = _calculatedAge! - 1; // Adjust age if birthday hasn't occurred yet this year
        }
      });
      _checkFormComplete(); // Check if form is complete after selecting birthday
    }
  }

  // Function to save both account data and login credentials
  Future<void> _saveAccountData() async {
    String email = _emailController.text.toLowerCase(); // Use lowercase email

    // Check if the email is already in use
    bool emailInUse = await _isEmailInUse(email);

    if (emailInUse) {
      setState(() {
        _emailAlreadyInUse = true; // Email already in use
      });
      return; // Stop the process if the email is already in use
    }

    // Save user data and login data
    await _saveUserData(email);
    await _saveLoginData(email);

    // Show account created message and navigate to MainScreen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created successfully!')),
    );

    // Add a small delay and then navigate to the main screen
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  // Function to save user information to the user_data.json file
  Future<void> _saveUserData(String email) async {
    final filePath = await _getUserJsonFilePath();
    final file = File(filePath);

    // Read existing data or create a new map
    String fileContent = await file.exists() ? await file.readAsString() : '{}';
    Map<String, dynamic> userData = jsonDecode(fileContent);

    // Create user payload with email as the key (in lowercase)
    Map<String, dynamic> userPayload = {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'height': '$selectedFeet\' $selectedInches"', // Store height as feet and inches
      'birthday': _selectedBirthday?.toIso8601String(), // Store birthday as ISO string
      'age': _calculatedAge.toString(), // Store calculated age
      'food_preference': selectedFoodPreference ?? '',
      'body_goals': selectedBodyGoals ?? '',
      'allergies': selectedAllergies ?? '',
      'workout_frequency': selectedWorkoutFrequency ?? '',
      'experience': selectedWorkoutExperience ?? '',
    };

    // Update or add the user payload under the email key (in lowercase)
    userData[email.toLowerCase()] = userPayload;

    // Write the updated data back to the JSON file
    await file.writeAsString(jsonEncode(userData));

    print('User data written successfully to $filePath'); // Debugging line
  }

  // Function to save login credentials (email and password) to the login_data.json file
  Future<void> _saveLoginData(String email) async {
    final filePath = await _getLoginJsonFilePath();
    final file = File(filePath);

    // Read existing data or create a new map
    String fileContent = await file.exists() ? await file.readAsString() : '{}';
    Map<String, dynamic> loginData = jsonDecode(fileContent);

    // Create login payload with email as the key (in lowercase)
    Map<String, dynamic> loginPayload = {
      'password': _passwordController.text, // Store password
    };

    // Update or add the login payload under the email key (in lowercase)
    loginData[email.toLowerCase()] = loginPayload;

    // Write the updated data back to the JSON file
    await file.writeAsString(jsonEncode(loginData));

    print('Login data written successfully to $filePath'); // Debugging line
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        children: [
          _buildUserDetailsPage(), // Step 1: User details (email, password, name, birthday)
          _buildSelectionPage('Food Preferences', ['Vegan', 'Vegetarian', 'Keto'], (val) {
            setState(() {
              selectedFoodPreference = val;
            });
          }, selectedFoodPreference),
          _buildSelectionPage('Body Goals', ['Lose Weight', 'Maintain', 'Build Muscle'], (val) {
            setState(() {
              selectedBodyGoals = val;
            });
          }, selectedBodyGoals),
          _buildSelectionPage('Allergies', ['Peanuts', 'Gluten', 'Dairy'], (val) {
            setState(() {
              selectedAllergies = val;
            });
          }, selectedAllergies),
          _buildSelectionPage('Workout Frequency', ['1-2 Days', '3-4 Days', '5+ Days'], (val) {
            setState(() {
              selectedWorkoutFrequency = val;
            });
          }, selectedWorkoutFrequency),
          _buildSelectionPage('Workout Experience', ['Beginner', 'Intermediate', 'Advanced'], (val) {
            setState(() {
              selectedWorkoutExperience = val;
            });
          }, selectedWorkoutExperience, isLast: true),
        ],
      ),
    );
  }

  // Step 1: User details page (email, password, first name, last name, height picker, birthday picker)
  Widget _buildUserDetailsPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) async {
                bool emailInUse = await _isEmailInUse(value.toLowerCase());
                setState(() {
                  _emailAlreadyInUse = emailInUse;
                });
                _checkFormComplete();
              },
            ),
            if (_emailAlreadyInUse)
              const Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Email already in use, please login.', style: TextStyle(color: Colors.red)),
                ],
              ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 20),
            const Text('Height', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selectedFeet = index + 4; // Heights starting from 4 feet
                      });
                    },
                    children: List<Widget>.generate(8, (int index) {
                      return Text('${index + 4}\''); // 4' to 11'
                    }),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40.0,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selectedInches = index; // Inches
                      });
                    },
                    children: List<Widget>.generate(12, (int index) {
                      return Text('$index"'); // 0" to 11"
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildBirthdayPicker(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isFormComplete && !_emailAlreadyInUse
                  ? () {
                      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    }
                  : null, // Disable if form is incomplete or email is in use
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormComplete && !_emailAlreadyInUse ? Colors.green : Colors.grey, // Change button color based on form completeness and email status
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  // Birthday picker
  Widget _buildBirthdayPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Birthday', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _selectBirthday(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedBirthday == null
                      ? 'Select your birthday'
                      : '${_selectedBirthday!.month}/${_selectedBirthday!.day}/${_selectedBirthday!.year}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
        if (_calculatedAge != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text('Your age is $_calculatedAge years'),
          ),
      ],
    );
  }

  // Selection pages for preferences, with a "Next" or "Complete" button
  Widget _buildSelectionPage(String title, List<String> options, Function(String) onSelected, String? selectedOption, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...options.map((option) => ListTile(
                title: Text(option),
                leading: Radio<String>(
                  value: option,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      onSelected(value!);
                    });
                  },
                ),
              )),
          const Spacer(),
          ElevatedButton(
            onPressed: selectedOption != null
                ? () {
                    if (isLast) {
                      _saveAccountData(); // Save and complete account creation
                    } else {
                      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    }
                  }
                : null, // Disable button if no option is selected
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedOption != null ? Colors.green : Colors.grey,
            ),
            child: Text(isLast ? 'Complete' : 'Next'),
          ),
        ],
      ),
    );
  }
}
