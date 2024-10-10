import 'package:flutter/material.dart';
import 'package:enbl_alpha/globals.dart'; // Assuming globals.dart contains the custom color definitions
import 'package:intl/intl.dart'; // Assuming you have intl for date formatting

class FitnessPage extends StatefulWidget {
  const FitnessPage({super.key});

  @override
  State<FitnessPage> createState() => _FitnessPageState();
}

class _FitnessPageState extends State<FitnessPage> {
  int _selectedIndex = 1;
  DateTime currentDate = DateTime.now();
  final List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  late ScrollController _scrollController; // Scroll controller for auto-scrolling

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(); // Initialize the scroll controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday(); // Auto-scroll after the widget is built
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the controller when not in use
    super.dispose();
  }

  void _scrollToToday() {
    int today = DateTime.now().day - 1; // Get today's index (0-based)
    double position = today * 54.0; // 50 + 4 for padding/margin (adjust this as needed)
    _scrollController.animateTo(position,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  // Function to open the month/year selection pop-up
  void _showMonthYearPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                          currentDate = DateTime(currentDate.year, currentDate.month - 1);
                        });
                      },
                    ),
                    Text(
                      DateFormat('MMMM yyyy').format(currentDate),
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        setState(() {
                          currentDate = DateTime(currentDate.year, currentDate.month + 1);
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Calendar layout for the pop-up
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: daysInMonth(currentDate),
                    itemBuilder: (context, index) {
                      final date = DateTime(currentDate.year, currentDate.month, index + 1);
                      bool isToday = date.day == DateTime.now().day && date.month == DateTime.now().month;

                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Close the dialog when a day is selected
                          setState(() {
                            currentDate = DateTime(currentDate.year, currentDate.month, index + 1);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isToday ? customGreen : Colors.transparent,
                            shape: BoxShape.circle,
                            border: isToday ? null : Border.all(color: Colors.grey),
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

                    String weekday = weekdays[(index + DateTime(currentDate.year, currentDate.month, 1).weekday - 1) % 7];

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
            ],
          ),
        ),
      ),
    );
  }
}
