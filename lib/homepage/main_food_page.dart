import 'package:flutter/material.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle tab switch logic here if needed
  }

  // Helper methods go here
  Widget buildOverviewRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Roboto', // Use Roboto font
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: IconButton(
            padding: EdgeInsets.zero, // Remove default padding
            icon: const Icon(Icons.add), // Correct way to pass the icon
            onPressed: () {
              // Handle press
            },
            color: Colors.white,
            iconSize: 16, // Adjust the icon size if necessary
          ),
        ),
      ],
    );
  }

  Widget buildHorizontalList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Item ${index + 1}',
                style: const TextStyle(
                  fontFamily: 'Roboto', // Use Roboto font
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildStartWorkoutRow() {
    return Row(
      children: [
        const Text(
          "Start Workout",
          style: TextStyle(
            fontFamily: 'Roboto', // Use Roboto font
            color: Colors.green,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {
            // Handle back arrow press
          },
          color: Colors.green,
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
                // Header with welcome text and NAME
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "WELCOME",
                        style: TextStyle(
                          fontFamily: 'Roboto', // Use Roboto font
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " Guest",
                        style: TextStyle(
                          fontFamily: 'Roboto', // Use Roboto font
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Today's Generated Workout
                const Text(
                  "Today's Generated Workout",
                  style: TextStyle(
                    fontFamily: 'Roboto', // Use Roboto font
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Workout Sections
                buildOverviewRow("Chest & Tricep Overview"),
                const SizedBox(height: 20),
                buildHorizontalList(),
                const SizedBox(height: 20),
                buildStartWorkoutRow(),
                const SizedBox(height: 20),

                buildOverviewRow("Back & Bicep Overview"),
                const SizedBox(height: 20),
                buildHorizontalList(),
                const SizedBox(height: 20),
                buildStartWorkoutRow(),
                const SizedBox(height: 20),

                buildOverviewRow("Shoulder & Abs Overview"),
                const SizedBox(height: 20),
                buildHorizontalList(),
                const SizedBox(height: 20),
                buildStartWorkoutRow(),
                const SizedBox(height: 20),

                buildOverviewRow("Legs Overview"),
                const SizedBox(height: 20),
                buildHorizontalList(),
                const SizedBox(height: 20),
                buildStartWorkoutRow(),
                const SizedBox(height: 20),

                buildOverviewRow("Full Body Overview"),
                const SizedBox(height: 20),
                buildHorizontalList(),
                const SizedBox(height: 20),
                buildStartWorkoutRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
