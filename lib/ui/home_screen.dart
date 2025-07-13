import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utiles/custom _bottom_navigationbar.dart';
import '../utiles/todo_bottom_sheet.dart';
import '../utiles/toggleButtonList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String todayDate = DateFormat('EEE dd MMMM yyyy').format(DateTime.now());
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
            left: 20,
            bottom: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                todayDate,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search Task",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ToggleButtonList(),
              Image.asset('assets/home_view.png', height: 300),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isMenuOpen = !_isMenuOpen;
                    });
                  },
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _isMenuOpen ? Icons.close : Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        _isMenuOpen
            ? Padding(
                padding: const EdgeInsets.only(bottom: 100, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildMenuButton(text: "Setup Journal", outlined: true),
                    const SizedBox(height: 10),
                    _buildMenuButton(text: "Setup Habit", outlined: true),
                    const SizedBox(height: 10),
                    _buildMenuButton(text: "Add List"),
                    const SizedBox(height: 10),
                    _buildMenuButton(text: "Add Note"),
                    const SizedBox(height: 10),
                    _buildMenuButton(
                      text: "Add Todo",
                      onpressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) =>
                              AddTodoBottomSheet(context: context),
                        );
                      },
                    ),
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Widget _buildMenuButton({
    required String text,
    onpressed,
    bool outlined = false,
  }) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: outlined ? Colors.white : Colors.orange,
        foregroundColor: outlined ? Colors.orange : Colors.white,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: outlined
              ? const BorderSide(color: Colors.orange)
              : BorderSide.none,
        ),
      ),
      child: Text(text),
    );
  }
}
