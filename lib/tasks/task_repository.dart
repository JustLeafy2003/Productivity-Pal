import 'package:sqflite_common/sqlite_api.dart';
import 'package:productivity_pal/tasks/task_object.dart';

class TaskRepository {
  final Database _database;

  TaskRepository(this._database);

  Future<List<Task>> getAllTasks(int userId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'task',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Task(
        taskID: maps[i]['task_id'],
        title: maps[i]['title'],
        content: maps[i]['description'],
        dueDate: maps[i]['due_date'],
        completed: maps[i]['status'] == 'completed',
        userId: userId,
      );
    });
  }

  Future<int> insertTask(Task task, int userId) async {
    int taskId = await _database.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return taskId;
  }

  Future<void> deleteTask(int taskId) async {
    await _database.delete(
      'task',
      where: 'task_id = ?',
      whereArgs: [taskId],
    );
  }

  Future<void> updateTask(Task task) async {
    await _database.update(
      'task',
      task.toMap(),
      where: 'task_id = ?',
      whereArgs: [task.taskID],
    );
  }
}
