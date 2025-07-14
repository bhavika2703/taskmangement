class TaskModel {
  final String priority;
  final String priorityIcon;
  final String title;
  final String description;
  final String time;
  final String date;
  final String status;
  final String priorityLevel; // high, medium, low

  TaskModel({
    required this.priority,
    required this.priorityIcon,
    required this.title,
    required this.description,
    required this.time,
    required this.date,
    required this.status,
    required this.priorityLevel,
  });
}
