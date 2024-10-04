import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 2; 

  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  final ScrollController _scrollController = ScrollController(); // ScrollController for auto-scroll

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.add(message);
        _messageController.clear();
      });
      // Delay the scroll to ensure the message is added to the widget tree first
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define a color to be used for both the navigation bar and the chat box
    const Color barColor = Colors.white; // Example: white color

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Robot head icon centered at the top
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Icon(
                  Icons.android,
                  size: 50,
                  color: Colors.green,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController, // Attach the scroll controller
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display messages
                      ..._messages.map((msg) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  msg,
                                  style: const TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            // Chat input box blending into the navigation bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: barColor, // Set the same color as the navigation bar
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Send a message",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) => _sendMessage(), // Send message on pressing enter
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.green),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
