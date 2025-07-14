import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Notification cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  NotificationCard(
                    emoji: '🔔',
                    title: 'Reminder',
                    message:
                        'Your interview with Sarah starts in 30 minutes. Get ready!',
                  ),
                  NotificationCard(
                    emoji: '⏳',
                    title: 'Upcoming Task',
                    message:
                        "Don't forget to complete Alex Interview before the deadline.",
                  ),
                  NotificationCard(
                    emoji: '✅',
                    title: 'Task Completed',
                    message:
                        "Great job! You've checked off a task. Keep going!",
                  ),
                  NotificationCard(
                    emoji: '⏳',
                    title: 'Task Due',
                    message:
                        'Your task "Submit Report" is due in 1 hour. Stay on track!',
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

// Notification Card Widget
class NotificationCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String message;

  const NotificationCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$emoji $title',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
