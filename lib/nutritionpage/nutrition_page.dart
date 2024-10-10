import 'package:flutter/material.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPage();
}

class _NutritionPage extends State<NutritionPage> {
  int _selectedIndex = 3;
  final List<int> _selectedDays = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle tab switch logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child:SingleChildScrollView(
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
                  color: Colors.green,
                ),
                textAlign: TextAlign.left,
              ),

              //Calendar Month
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Ensure space between text and icons
                children: [
                  const Row(
                    children: [
                      Text(
                        "September",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 15,),
                      Text (
                        "Year",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  // Arrows
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          // Handle back arrow press
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          // Handle forward arrow press
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),
              //Calendar Days Monday - Friday
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Sun",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Mon",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Tue",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Wed",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Thu",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Fri",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Sat",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),

              const SizedBox(height: 10),
              //Calendar numbered Days 1-30
              //for now cause sept has 30 days
              SizedBox(
                height: 50, // Set height for the day boxes
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 30, // Number of days
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedDays.contains(index);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedDays.remove(index); // Deselect the day
                          } else {
                            _selectedDays.add(index); // Select the day
                          }
                        });
                      },
                      child: Container(
                        width: 50, // Width of each day box
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4.0), // Space between days
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? Colors.green
                              : Colors
                                  .transparent, // Green if selected, transparent otherwise
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}', // Day number
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors
                                      .black, // White if selected, black otherwise
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),
              //a few Recipes
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0), // Space between each item
                padding: const EdgeInsets.all(12.0), // Padding inside the container
                width: MediaQuery.of(context).size.width *
                    0.90, // Adjust the width to 85% of screen width
                height: 130, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Changes position of shadow
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
                        color: Colors
                            .white, // Background color for the icon container
                        borderRadius: BorderRadius.circular(
                            25.0), // Rounded square corners
                      ),
                      child: const Icon(
                        Icons
                            .fastfood, // Example icon, replace with actual food icon
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(width: 15.0), // Space between icon and text

                    // Title
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centers the text vertically
                        children: [
                          Text(
                            "Food Title", // Replace with actual title
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  8.0), // Space between title and description
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Prep Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Cook Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Total Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0), // Space between each item
                padding: const EdgeInsets.all(12.0), // Padding inside the container
                width: MediaQuery.of(context).size.width *
                    0.90, // Adjust the width to 85% of screen width
                height: 130, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Changes position of shadow
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
                        color: Colors
                            .white, // Background color for the icon container
                        borderRadius: BorderRadius.circular(
                            25.0), // Rounded square corners
                      ),
                      child: const Icon(
                        Icons
                            .fastfood, // Example icon, replace with actual food icon
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(width: 15.0), // Space between icon and text

                    // Title
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centers the text vertically
                        children: [
                          Text(
                            "Food Title", // Replace with actual title
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  8.0), // Space between title and description
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Prep Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Cook Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Total Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0), // Space between each item
                padding: const EdgeInsets.all(12.0), // Padding inside the container
                width: MediaQuery.of(context).size.width *
                    0.90, // Adjust the width to 85% of screen width
                height: 130, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Changes position of shadow
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
                        color: Colors
                            .white, // Background color for the icon container
                        borderRadius: BorderRadius.circular(
                            25.0), // Rounded square corners
                      ),
                      child: const Icon(
                        Icons
                            .fastfood, // Example icon, replace with actual food icon
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(width: 15.0), // Space between icon and text

                    // Title
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centers the text vertically
                        children: [
                          Text(
                            "Food Title", // Replace with actual title
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  8.0), // Space between title and description
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Prep Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Cook Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Total Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0), // Space between each item
                padding: const EdgeInsets.all(12.0), // Padding inside the container
                width: MediaQuery.of(context).size.width *
                    0.90, // Adjust the width to 85% of screen width
                height: 130, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Changes position of shadow
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
                        color: Colors
                            .white, // Background color for the icon container
                        borderRadius: BorderRadius.circular(
                            25.0), // Rounded square corners
                      ),
                      child: const Icon(
                        Icons
                            .fastfood, // Example icon, replace with actual food icon
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(width: 15.0), // Space between icon and text

                    // Title
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centers the text vertically
                        children: [
                          Text(
                            "Food Title", // Replace with actual title
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  8.0), // Space between title and description
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Prep Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Cook Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Total Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0), // Space between each item
                padding: const EdgeInsets.all(12.0), // Padding inside the container
                width: MediaQuery.of(context).size.width *
                    0.90, // Adjust the width to 85% of screen width
                height: 130, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Changes position of shadow
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
                        color: Colors
                            .white, // Background color for the icon container
                        borderRadius: BorderRadius.circular(
                            25.0), // Rounded square corners
                      ),
                      child: const Icon(
                        Icons
                            .fastfood, // Example icon, replace with actual food icon
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(width: 15.0), // Space between icon and text

                    // Title
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centers the text vertically
                        children: [
                          Text(
                            "Food Title", // Replace with actual title
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  8.0), // Space between title and description
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Prep Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Cook Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Total Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0), // Space between each item
                padding: const EdgeInsets.all(12.0), // Padding inside the container
                width: MediaQuery.of(context).size.width *
                    0.90, // Adjust the width to 85% of screen width
                height: 130, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Changes position of shadow
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
                        color: Colors
                            .white, // Background color for the icon container
                        borderRadius: BorderRadius.circular(
                            25.0), // Rounded square corners
                      ),
                      child: const Icon(
                        Icons
                            .fastfood, // Example icon, replace with actual food icon
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(width: 15.0), // Space between icon and text

                    // Title
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centers the text vertically
                        children: [
                          Text(
                            "Food Title", // Replace with actual title
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  8.0), // Space between title and description
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Prep Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Cook Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "Total Time", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "xx mins", // Replace with actual description
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
);
  }
}
