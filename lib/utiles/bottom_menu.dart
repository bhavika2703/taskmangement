import 'package:flutter/material.dart';

class FloatingMenuExample extends StatefulWidget {
  const FloatingMenuExample({super.key});

  @override
  State<FloatingMenuExample> createState() => _FloatingMenuExampleState();
}

class _FloatingMenuExampleState extends State<FloatingMenuExample>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  Widget buildMenuButton(
    String text,
    Color bgColor,
    Color textColor, {
    VoidCallback? onPressed,
    bool border = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 6,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: border
                ? const BorderSide(color: Colors.orange, width: 1.5)
                : BorderSide.none,
          ),
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: Stack(
        children: [
          const Center(child: Text("Home Page")),
          Positioned(
            right: 20,
            bottom: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (isMenuOpen) ...[
                  buildMenuButton(
                    "Setup Journal",
                    Colors.white,
                    Colors.orange,
                    border: true,
                  ),
                  buildMenuButton(
                    "Setup Habit",
                    Colors.white,
                    Colors.orange,
                    border: true,
                  ),
                  buildMenuButton("Add List", Colors.orange, Colors.white),
                  buildMenuButton("Add Note", Colors.orange, Colors.white),
                  buildMenuButton("Add Todo", Colors.orange, Colors.white),
                ],
                // FAB Toggle
                GestureDetector(
                  onTap: toggleMenu,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              hintText: "eg : Meeting with client",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: "Description",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.calendar_today, color: Colors.grey),
              SizedBox(width: 16),
              Icon(Icons.access_time, color: Colors.grey),
              SizedBox(width: 16),
              Icon(Icons.flag, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 20,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: () {
                  Navigator.pop(context); // Save and close
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
