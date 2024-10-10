import 'package:flutter/material.dart';
import 'package:enbl_alpha/globals.dart';
import 'package:intl/intl.dart'; // For date formatting

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPage();
}

class _NutritionPage extends State<NutritionPage> {
  int _selectedIndex = 3;
  final List<int> _selectedDays = [];

  // Weekday names to cycle through
  final List<String> weekdays = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];

  // Get the current month and number of days in that month
  DateTime now = DateTime.now();
  late String currentMonth;
  late int daysInMonth;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    currentMonth = DateFormat('MMMM').format(now);
    daysInMonth = DateTime(now.year, now.month + 1, 0).day; // Get number of days in the current month
    _scrollController = ScrollController();

    // Scroll to today's date after layout is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  void _scrollToToday() {
    // Calculate the scroll offset for today's date
    double dayWidth = 60.0; // Estimated width of each day item
    double offset = (now.day - 1) * dayWidth;

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Function to show the calendar pop-up
  void _showCalendarPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Get the first day of the month to align the days
            DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
            int startingWeekday = firstDayOfMonth.weekday % 7; // Sunday is 0, Monday is 1, etc.

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              now = DateTime(now.year, now.month - 1, 1);
                              currentMonth = DateFormat('MMMM').format(now);
                              daysInMonth = DateTime(now.year, now.month + 1, 0).day;
                            });
                          },
                        ),
                        Text(
                          '${DateFormat('MMMM').format(now)} ${now.year}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            setState(() {
                              now = DateTime(now.year, now.month + 1, 1);
                              currentMonth = DateFormat('MMMM').format(now);
                              daysInMonth = DateTime(now.year, now.month + 1, 0).day;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Display a traditional calendar (7 columns for weekdays)
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: daysInMonth + startingWeekday,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7, // 7 columns for the days of the week
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        if (index < startingWeekday) {
                          return const SizedBox(); // Empty slots before the first day
                        }
                        int day = index - startingWeekday + 1; // Calculate day number
                        return Container(
                          decoration: BoxDecoration(
                            color: day == now.day ? customGreen : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$day',
                              style: TextStyle(
                                color: day == now.day ? Colors.white : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Close button
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Close dialog and update the view with the selected month/year
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('ok'),
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

  Widget buildRecipe(BuildContext context, String recipeTitle, String prepTime,
      String cookTime, String totalTime) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width * 0.90,
      height: 130,
      decoration: BoxDecoration(
        color: customGreen,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          // Icon container
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: foodExample, // Use the global image variable here
          ),
          const SizedBox(width: 15.0), // Space between icon and text

          // Title and other recipe details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  recipeTitle, // Dynamic recipe title passed through the function
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Prep Time",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          prepTime, // Dynamic prep time passed through the function
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        const Text(
                          "Cook Time",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          cookTime, // Dynamic cook time passed through the function
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        const Text(
                          "Total Time",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          totalTime, // Dynamic total time passed through the function
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title: NUTRITION
                const Text(
                  "NUTRITION",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: customGreen,
                  ),
                  textAlign: TextAlign.left,
                ),

                // Calendar Month (clickable)
                GestureDetector(
                  onTap: () {
                    _showCalendarPopUp(context); // Show calendar pop-up on click
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Text(                   
                        currentMonth,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Calendar numbered days and weekdays (scrolling horizontally)
                SizedBox(
                  height: 90, // Set height for both day numbers and weekday names
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: daysInMonth, // Number of days in the current month
                    itemBuilder: (context, index) {
                      // Determine the weekday by calculating the remainder when dividing by 7
                      String weekday = weekdays[(index + 1) % 7];

                      bool isToday = now.day == index + 1; // Check if it's today

                      return Column(
                        children: [
                          // Display weekday name
                          Text(
                            weekday,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,fontFamily: 'Roboto',),
                          ),
                          const SizedBox(height: 10), // Space between weekday and day number

                          // Display day number
                          Container(
                            width: 50, // Width of each day box
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isToday ? customGreen : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}', // Day number
                                style: TextStyle(
                                  color: isToday
                                      ? Colors.white
                                      : Colors.black, // White if today, black otherwise
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

                const SizedBox(height: 10),

                // Example Recipes
                buildRecipe(context, "Grilled Chicken Salad", "10 mins", "20 mins", "30 mins"),
                const SizedBox(height: 10),
                buildRecipe(context, "Vegan Burger", "15 mins", "25 mins", "40 mins"),
                const SizedBox(height: 10),
                buildRecipe(context, "Avocado Toast", "5 mins", "0 mins", "5 mins"),
                const SizedBox(height: 10),
                buildRecipe(context, "Pasta Bolognese", "15 mins", "45 mins", "60 mins"),
                const SizedBox(height: 10),
                buildRecipe(context, "Berry Smoothie", "5 mins", "0 mins", "5 mins"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
