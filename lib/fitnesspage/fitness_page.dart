import 'package:flutter/material.dart';
import 'package:enbl_alpha/globals.dart'; // Assuming globals.dart contains the custom color definitions
import 'package:intl/intl.dart'; // Assuming you have intl for date formatting

class Exercise {
  final String name;
  final int reps;
  final int sets;
  final String rest;
  final bool isComplete;
  final String imagePath;

  Exercise({
    required this.name,
    required this.reps,
    required this.sets,
    required this.rest,
    this.isComplete = false,
    required this.imagePath,
  });
}

class FitnessPage extends StatefulWidget {
  const FitnessPage({super.key});

  @override
  State<FitnessPage> createState() => _FitnessPageState();
}

class _FitnessPageState extends State<FitnessPage> {
  int _selectedIndex = 1;
  DateTime currentDate = DateTime.now();
  final List<String> weekdays = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];
  late ScrollController
      _scrollController; // Scroll controller for auto-scrolling

  // List of exercises
  List<Exercise> exercises = [
    Exercise(
        name: "Chest Dips",
        reps: 10,
        sets: 3,
        rest: "1 Minute",
        imagePath: 'assets/image/WomanDoingShoulders.jpeg'),
    Exercise(
        name: "Flat Bench Press",
        reps: 10,
        sets: 3,
        rest: "1 Minute",
        imagePath: 'assets/image/WomanDoingShoulders.jpeg'),
    Exercise(
        name: "Incline Bench Press",
        reps: 10,
        sets: 3,
        rest: "1 Minute",
        imagePath: 'assets/image/WomanDoingShoulders.jpeg'),
    Exercise(
        name: "Cable Tricep Pushdown",
        reps: 10,
        sets: 3,
        rest: "1 Minute",
        imagePath: 'assets/image/WomanDoingShoulders.jpeg'),
    Exercise(
        name: "Overhead Tricep Pushdown",
        reps: 10,
        sets: 3,
        rest: "1 Minute",
        imagePath: 'assets/image/WomanDoingShoulders.jpeg'),
  ];
// Additional variable to track the visibility of exercise details
  late List<bool> exerciseDetailsVisible;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    exerciseDetailsVisible = List.generate(
        exercises.length, (_) => false); // Initialize visibility list
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the controller when not in use
    super.dispose();
  }

  void _scrollToToday() {
    int today = DateTime.now().day - 1; // Get today's index (0-based)
    double position =
        today * 54.0; // 50 + 4 for padding/margin (adjust this as needed)
    _scrollController.animateTo(position,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  // Function to open the month/year selection pop-up
  void _showMonthYearPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: Colors.white.withOpacity(0.9),
          child: SizedBox(
            height: 400,
            child: Column(
              children: [
                // Month and Year Selection with arrows
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        setState(() {
                          currentDate =
                              DateTime(currentDate.year, currentDate.month - 1);
                        });
                      },
                    ),
                    Text(
                      DateFormat('MMMM yyyy').format(currentDate),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        setState(() {
                          currentDate =
                              DateTime(currentDate.year, currentDate.month + 1);
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Calendar layout for the pop-up
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: daysInMonth(currentDate),
                    itemBuilder: (context, index) {
                      final date = DateTime(
                          currentDate.year, currentDate.month, index + 1);
                      bool isToday = date.day == DateTime.now().day &&
                          date.month == DateTime.now().month;

                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context); // Close the dialog when a day is selected
                          setState(() {
                            currentDate = DateTime(
                                currentDate.year, currentDate.month, index + 1);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isToday ? customGreen : Colors.transparent,
                            shape: BoxShape.circle,
                            border:
                                isToday ? null : Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: isToday ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // OK Button to close the pop-up
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to calculate the number of days in the month
  int daysInMonth(DateTime date) {
    var firstDayOfNextMonth = (date.month < 12)
        ? DateTime(date.year, date.month + 1, 1)
        : DateTime(date.year + 1, 1, 1);
    return firstDayOfNextMonth.subtract(const Duration(days: 1)).day;
  }

  Widget _buildExerciseList() {
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 5),
          color: customGreen,
          child: GestureDetector(
            onTap: () {
              setState(() {
                exerciseDetailsVisible[index] = !exerciseDetailsVisible[index];

                if (!exerciseDetailsVisible[index]) {
                  exercises[index] = Exercise(
                    name: exercise.name,
                    reps: exercise.reps,
                    sets: exercise.sets,
                    rest: exercise.rest,
                    isComplete: !exercise.isComplete,
                    imagePath: exercise.imagePath,
                  );
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16), // Increased padding
              child: Row(
                children: [
                  // Conditionally render the image
                  if (exerciseDetailsVisible[
                      index]) // Show image only when details are visible
                    Container(
                      width: 80, // Fixed width for the image
                      height: 100, // Set height to the desired value
                      child: Image.asset(
                        exercise.imagePath,
                        fit: BoxFit
                            .cover, // Ensure the image covers the container
                      ),
                    ),
                  const SizedBox(
                      width: 12), // Increased spacing between image and text
                  Expanded(
                    // Expand this part to fill the remaining space
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.name,
                          style: TextStyle(
                            fontSize: 20, // Increased font size
                            fontWeight:
                                FontWeight.w900, // Increased font weight
                            color: exercise.isComplete
                                ? Colors.grey
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(
                            height: 2), // Increased spacing between elements
                        if (exerciseDetailsVisible[
                            index]) // Show details only if visible
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Reps',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          15, // Increased size for detail labels
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          5), // Add spacing between label and value
                                  Center(
                                    child: Text(
                                      '${exercise.reps}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            12, // Increased size for detail values
                                        fontWeight: FontWeight
                                            .bold, // Bold detail values
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sets',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          5), // Add spacing between label and value
                                  Center(
                                    child: Text(
                                      '${exercise.sets}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rest',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          5), // Add spacing between label and value
                                  Center(
                                    child: Text(
                                      '${exercise.rest}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Complete',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          5), // Add spacing between label and icon
                                  Center(
                                    child: Icon(
                                      exercise.isComplete
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (!exerciseDetailsVisible[
                      index]) // Show completion status icon
                    Image.asset(
                      exercise.isComplete
                          ? 'assets/image/checkmark.png'
                          : 'assets/image/arrow-up.png',
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
              // Title and Profile Image Row (similar to Profile Page)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "WORKOUTS",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: customGreen,
                    ),
                  ),
                  ClipOval(
                    child: Image.asset(
                      'assets/image/GymBroProfile.jpg', // Replace with an appropriate image for fitness
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover, // Ensures the image covers the circle
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // Month and Calendar display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _showMonthYearPicker,
                    child: Text(
                      DateFormat('MMMM').format(currentDate),
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Calendar with weekdays and day numbers scrolling together
              SizedBox(
                height: 90, // Height for both weekday and day numbers
                child: ListView.builder(
                  controller: _scrollController, // Attach the scroll controller
                  scrollDirection: Axis.horizontal,
                  itemCount: daysInMonth(currentDate),
                  itemBuilder: (context, index) {
                    bool isToday = currentDate.year == DateTime.now().year &&
                        currentDate.month == DateTime.now().month &&
                        index + 1 == DateTime.now().day;

                    String weekday = weekdays[(index +
                            DateTime(currentDate.year, currentDate.month, 1)
                                .weekday -
                            1) %
                        7];

                    return Column(
                      children: [
                        Text(
                          weekday,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isToday ? customGreen : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: isToday ? Colors.white : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Exercise list
              Expanded(child: _buildExerciseList()),
            ],
          ),
        ),
      ),
    );
  }
}
