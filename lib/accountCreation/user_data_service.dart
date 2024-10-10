import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Path to the JSON file
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/JSON_files/user_data.json');
}

// Global getter to read user data from JSON
Future<Map<String, dynamic>> getUserData() async {
  try {
    final file = await _localFile;

    // Check if the file exists
    if (await file.exists()) {
      // Read the file
      String contents = await file.readAsString();

      // Decode the JSON
      Map<String, dynamic> jsonData = jsonDecode(contents);
      return jsonData;
    } else {
      // If the file doesn't exist, return an empty map
      return {};
    }
  } catch (e) {
    print('Error reading JSON: $e');
    return {};
  }
}

// Global setter to write or update user data to JSON
Future<void> setUserData(String email, Map<String, dynamic> userData) async {
  try {
    final file = await _localFile;

    // Read the existing data
    Map<String, dynamic> jsonData = await getUserData();

    // Update the data for the specific email key
    jsonData[email] = userData;

    // Encode the updated map to a JSON string
    String jsonString = jsonEncode(jsonData);

    // Write the JSON string to the file
    await file.writeAsString(jsonString);
  } catch (e) {
    print('Error writing JSON: $e');
  }
}
