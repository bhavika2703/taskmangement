import 'package:flutter/material.dart';
import '../model/task_model.dart';
import '../utiles/task_card.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});

  final List<Map<String, String>> dates = [
    {"day": "Tue", "date": "15"},
    {"day": "Wed", "date": "16"},
    {"day": "Thu", "date": "17"},
    {"day": "Fri", "date": "18"},
    {"day": "Sat", "date": "19"},
    {"day": "Sun", "date": "20"},
    {"day": "Mon", "date": "21"},
    {"day": "Tue", "date": "22"},
    {"day": "Wed", "date": "23"},
  ];

  final List<TaskModel> tasks = [
    TaskModel(
      priority: 'High Priority',
      priorityIcon: '⚠️',
      title: 'Interview with Alex',
      description:
          'Plan questions, capture insights, and document key takeaways.',
      time: '10.30 AM',
      date: 'Mon, 18 Apr 2024',
      status: 'To-Do',
      priorityLevel: 'high',
    ),
    TaskModel(
      priority: 'Low Priority',
      priorityIcon: '✅',
      title: 'Product Meeting',
      description: '',
      time: '08.30 AM',
      date: 'Mon, 18 Apr 2024',
      status: 'To-Do',
      priorityLevel: 'low',
    ),
    TaskModel(
      priority: 'Medium Priority',
      priorityIcon: '⏳',
      title: 'Marketing Documentation',
      description: '',
      time: '01.00 PM',
      date: 'Mon, 18 Apr 2024',
      status: 'Completed',
      priorityLevel: 'medium',
    ),
  ];

  Color getPriorityColor(String level) {
    switch (level) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'to-do':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back),
                  Row(
                    children: const [
                      Icon(Icons.chevron_left),
                      SizedBox(width: 8),
                      Text(
                        'Apr 2024',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),

            // Date Selector
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  final isSelected = dates[index]['date'] == '18';
                  return Container(
                    width: 60,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dates[index]['day']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dates[index]['date']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                '18 April 2024',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            // Task List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    color: getPriorityColor(task.priorityLevel),
                    priority: task.priority,
                    priorityIcon: task.priorityIcon,
                    title: task.title,
                    description: task.description,
                    time: task.time,
                    date: task.date,
                    status: task.status,
                    statusColor: getStatusColor(task.status),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
