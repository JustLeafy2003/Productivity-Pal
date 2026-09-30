class Task {
  int? taskID;
  String title;
  String content;
  String? dueDate;
  bool completed;
  int userId;

  Task({
    this.taskID,
    required this.title,
    required this.content,
    this.dueDate,
    this.completed = false, // Default value is set to false
    required this.userId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          taskID == other.taskID &&
          title == other.title &&
          content == other.content &&
          dueDate == other.dueDate &&
          completed == other.completed &&
          userId == other.userId;

  @override
  int get hashCode =>
      taskID.hashCode ^
      title.hashCode ^
      content.hashCode ^
      dueDate.hashCode ^
      completed.hashCode ^
      userId.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'task_id': taskID,
      'title': title,
      'description': content,
      'due_date': dueDate,
      'status': completed ? 'completed' : 'incomplete',
      'user_id': userId,
    };
  }
}
