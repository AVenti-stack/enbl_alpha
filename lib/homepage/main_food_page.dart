import 'package:flutter/material.dart';
import 'package:enbl_alpha/globals.dart'; // Global variables

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  String firstName = "Guest"; // Default value is "Guest"
  List<int> _firstListItems = [
    1,
    2,
    3
  ]; // List of initial items for the first horizontal list
  List<bool> _isAddedList = List<bool>.filled(
      9, false); // Track which squares are added to the first list

  @override
  void initState() {
    super.initState();
    _loadFirstName(); // Load the user's first name when the page is initialized
  }

  // Function to load the first name from the JSON file
  Future<void> _loadFirstName() async {
    setState(() {
      firstName = "John"; // Example first name
      firstName = firstName.toUpperCase();
    });
  }

  // Show a dialog pop-up when the plus button is clicked
  // Show a dialog pop-up when the plus button is clicked
  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Colors.white
                  .withOpacity(0.8), // Set the background with transparency
              child: Container(
                width: double.infinity, // Take up full width
                height: MediaQuery.of(context).size.height *
                    0.5, // 50% of the screen height
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('X'),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 columns
                          crossAxisSpacing: 10, // Space between columns
                          mainAxisSpacing: 10, // Space between rows
                        ),
                        itemCount: 9, // 9 squares
                        itemBuilder: (context, index) {
                          return ToggleSquare(
                            isAdded: _isAddedList[
                                index], // Pass the state of the square
                            onToggle: () {
                              setState(() {
                                _toggleItem(index); // Toggle the state
                              });
                            }, // Toggle the state
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Function to toggle an item in the pop-up and update the state for the first list
  void _toggleItem(int index) {
    setState(() {
      _isAddedList[index] = !_isAddedList[index]; // Toggle the state
      if (_isAddedList[index]) {
        _addItem(index + 1); // Add the item to the first list
      } else {
        _removeItem(index + 1); // Remove the item from the first list
      }
    });
  }

  // Function to build the first horizontal list with dynamic items
  // Function to build the first horizontal list with dynamic items
  Widget buildFirstHorizontalList() {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _firstListItems.length +
            3, // Always show 3 initial items plus toggled items
        itemBuilder: (context, index) {
          if (index < 3) {
            // Show the initial 3 boxes (never removed)
            return buildBlueBox(index + 1);
          } else {
            // Show additional toggled boxes
            return buildBlueBox(_firstListItems[index - 3]);
          }
        },
      ),
    );
  }

  // Function to create a blue box
  Widget buildBlueBox(int item) {
    return Container(
      width: 150,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: workoutexample,
    );
  }

// Function to add an item to the first list (but not the initial 3 items)
  void _addItem(int item) {
    if (!_firstListItems.contains(item)) {
      setState(() {
        _firstListItems.add(item); // Add a new item if it doesn't already exist
      });
    }
  }

// Function to remove an item from the first list (but not the initial 3 items)
  void _removeItem(int item) {
    if (_firstListItems.contains(item)) {
      setState(() {
        _firstListItems.remove(item); // Remove the item from the list
      });
    }
  }

  Widget buildStartWorkoutRow() {
    return Row(
      children: [
        const Text(
          "Start Workout",
          style: TextStyle(
            color: customGreen,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {},
          color: customGreen,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with welcome text and first name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        "WELCOME",
                        style: TextStyle(
                          color: customGreen,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        firstName, // Display the first name instead of "Guest"
                        style: const TextStyle(
                          color: customGreen,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Today's Generated Workout
                const Text(
                  "Today's Generated Workout",
                  style: TextStyle(
                      fontSize: 25,
                      color: customGreen,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    // Workout Sections
                    buildOverviewRow("Chest & Tricep Overview"),
                    const SizedBox(width: 115),
                    Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: customGreen,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          _showPopUp(
                              context); // Show dialog when the plus icon is clicked
                        },
                        color: Colors.white,
                        iconSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                buildFirstHorizontalList(), // Only the first horizontal list is affected by the pop-up
                const SizedBox(height: 20),
                buildStartWorkoutRow(),
                const SizedBox(height: 20),

                // Other sections that are not affected by the pop-up
                const Text(
                  "Tomorrow's Workout",
                  style: TextStyle(
                      fontSize: 25,
                      color: customGreen,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 20),
                buildOverviewRow("Legs Overview"),
                const SizedBox(height: 20),
                buildHorizontalList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to build other horizontal lists
  Widget buildHorizontalList() {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3, // For example, fixed number of items for other lists
        itemBuilder: (context, index) {
          return buildBlueBox(
              index + 1); // Call the function to create a blue box
        },
      ),
    );
  }

  Widget buildOverviewRow(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

// Widget for the toggleable squares in the pop-up
class ToggleSquare extends StatelessWidget {
  final bool isAdded;
  final VoidCallback onToggle;

  const ToggleSquare({required this.isAdded, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60, // Height of the square
            width: 75, // Width of the square
            color: Colors.grey[400], // Background color of the square
            child: Center(
              child: Icon(
                Icons.fitness_center, // Dumbbell icon
                size: 30, // Adjust the size of the dumbbell icon
                color: Colors.black, // Set the color of the dumbbell icon
              ),
            ), // A grey square above the circle
          ),
          const SizedBox(height: 10), // Space between the square and the circle
          Container(
            height: 20, // Smaller circle
            width: 20, // Smaller circle
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAdded
                  ? Colors.red
                  : Colors.green, // Red for minus, Green for plus
            ),
            child: Icon(
              isAdded
                  ? Icons.remove
                  : Icons.add, // Toggle between plus and minus
              color: Colors.white,
              size: 20, // Adjust icon size to fit smaller circle
            ),
          ),
        ],
      ),
    );
  }
}
