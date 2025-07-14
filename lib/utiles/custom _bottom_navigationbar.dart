import 'package:flutter/material.dart';

import '../ui/calendar_screen.dart';
import '../ui/home_screen.dart';
import '../ui/notification_screen.dart';
import '../ui/profile_screen.dart';

class CustomBottomNavScreen extends StatefulWidget {
  const CustomBottomNavScreen({super.key});

  @override
  State<CustomBottomNavScreen> createState() => _CustomBottomNavScreenState();
}

class _CustomBottomNavScreenState extends State<CustomBottomNavScreen> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<IconData> icons = [
    Icons.home,
    Icons.notifications_none,
    Icons.calendar_today,
  ];
  final List<Widget> screens = [
    HomeScreen(),
    NotificationScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(0, Icons.home, "Home"),
            navItem(1, Icons.notifications_none, "Notification"),
            navItem(2, Icons.calendar_today, "Calendar"),
            profileItem(3),
          ],
        ),
      ),
    );
  }

  Widget navItem(int index, IconData icon, String label) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.orange : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          if (isSelected)
            Container(
              height: 3,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
        ],
      ),
    );
  }

  Widget profileItem(int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 14,
            child: Icon(Icons.person),
            // backgroundImage: AssetImage("assets/images/profile.jpg"),
          ),
          const SizedBox(height: 4),
          Text(
            "Profile",
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
