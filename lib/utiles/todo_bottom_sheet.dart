import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AddTodoBottomSheet extends StatefulWidget {
  final BuildContext context;

  const AddTodoBottomSheet({super.key, required this.context});

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  late FocusNode descriptionFocusNode;
  String selectedPriority = 'Low Priority';
  Color selectedColor = Colors.green;
  IconData selectedIcon = Icons.check_box;
  bool _isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    descriptionFocusNode = FocusNode();

    descriptionFocusNode.addListener(() {
      if (descriptionFocusNode.hasFocus && !_isDialogOpen) {
        _isDialogOpen = true;
        Future.delayed(const Duration(milliseconds: 100), () {
          _showPriorityDialog(widget.context);
        });
      }
    });
  }

  @override
  void dispose() {
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "New Todo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "eg : Meeting with client",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                focusNode: descriptionFocusNode,
                decoration: InputDecoration(
                  hintText: selectedPriority == 'Low Priority'
                      ? "Description"
                      : "$selectedPriority",
                  hintStyle: TextStyle(
                    color: selectedPriority == 'Low Priority'
                        ? Colors.black
                        : selectedColor,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _showCalendarBottomSheet(context);
                    },
                    icon: Icon(Icons.calendar_today, color: Colors.grey),
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    onPressed: () async {
                      final selected = await _showTimeSelectionSheet(context);
                      if (selected != null) {
                        print("User selected time: $selected");
                        // Save the selected time to your form or state
                      }
                    },
                    icon: Icon(Icons.access_time, color: Colors.grey),
                  ),

                  SizedBox(width: 16),
                  Icon(Icons.flag, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.orange,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPriorityDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              SizedBox(height: 8),
              _buildPriorityOption(
                title: 'High Priority',
                color: Colors.red,
                icon: Icons.warning,
              ),
              const Divider(height: 1),
              _buildPriorityOption(
                title: 'Medium Priority',
                color: Colors.orange,
                icon: Icons.hourglass_bottom,
              ),
              const Divider(height: 1),
              _buildPriorityOption(
                title: 'Low Priority',
                color: Colors.green,
                icon: Icons.check_box,
              ),
            ],
          ),
        );
      },
    ).then((_) {
      _isDialogOpen = false;
      FocusScope.of(ctx).unfocus();
    });
  }

  Widget _buildPriorityOption({
    required String title,
    required Color color,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        setState(() {
          selectedPriority = title;
          selectedColor = color;
          selectedIcon = icon;
        });
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
      },
    );
  }

  void _showCalendarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        DateTime focusedDay = DateTime.now();
        DateTime? selectedDay;

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.watch_later_outlined),
                      SizedBox(width: 8),
                      Text(
                        "Select Due Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(),
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: focusedDay,
                    selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                    onDaySelected: (selected, focused) {
                      setState(() {
                        selectedDay = selected;
                        focusedDay = focused;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: () {
                            Navigator.pop(context, selectedDay);
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<String?> _showTimeSelectionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        List<String> timeSlots = [
          "09:30 AM",
          "10:00 AM",
          "10:30 AM",
          "11:00 AM",
          "11:30 AM",
          "12:00 PM",
          "12:30 PM",
          "01:00 PM",
          "01:30 PM",
        ];
        String? selectedTime;

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Text(
                    "Friday",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Apr 18, 2024",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.language, size: 18),
                      SizedBox(width: 6),
                      Text("Indian Standard Time (UTC+05:30)"),
                    ],
                  ),
                  const Divider(height: 32),
                  ...timeSlots.map((time) {
                    final isSelected = selectedTime == time;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Text(
                                time,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context, selectedTime);
                              },
                              child: const Text("Confirm"),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Back"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: () {
                            Navigator.pop(context, selectedTime);
                          },
                          child: const Text("Next"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
