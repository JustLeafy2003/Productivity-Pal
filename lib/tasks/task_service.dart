import 'task_object.dart';
import 'task_repository.dart';

class TaskService {
  final TaskRepository _taskRepository;

  TaskService(this._taskRepository);

  Future<List<Task>> getAllTasks(int userId) async {
    return await _taskRepository.getAllTasks(userId);
  }

  Future<int> addTask(Task task, int userId) async {
    return await _taskRepository.insertTask(task, userId);
  }

  Future<void> deleteTask(int taskId) async {
    await _taskRepository.deleteTask(taskId);
  }

  Future<void> updateTask(Task task) async {
    await _taskRepository.updateTask(task);
  }
}
