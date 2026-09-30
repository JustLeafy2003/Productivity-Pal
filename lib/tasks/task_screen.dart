import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../user/user_service.dart';
import '../tasks/task_object.dart';
import '../tasks/task_service.dart';
import '../tasks/task_widget.dart';

class TaskScreen extends StatefulWidget {
  final int userId;
  final UserService userService;
  final TaskService taskService;
  final bool isDarkMode;

  const TaskScreen({
    required this.userId,
    required this.userService,
    required this.taskService,
    required this.isDarkMode,
    Key? key,
  }) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Future<List<Task>> _tasksFuture;
  late List<Task> _tasks = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _selectedDueDate;
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late final Map<int, Duration> _remainingTime = {};

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
    _tasksFuture = _loadTasks();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<List<Task>> _loadTasks() async {
    final int userId = widget.userId;
    return widget.taskService.getAllTasks(userId);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Task>>(
          future: _tasksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading tasks'),
              );
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No tasks available'),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 150.0,
                      child: _buildAddTaskButton(isDarkMode),
                    ),
                  ],
                ),
              );
            } else {
              _tasks = snapshot.data!;
              for (final task in _tasks) {
                _startOrResumeCountdownTimer(task);
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = (constraints.maxWidth / 200).floor();
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: _tasks.length + 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == _tasks.length) {
                        return _buildAddTaskButton(isDarkMode);
                      } else {
                        final task = _tasks[index];
                        return TaskItem(
                          task: task,
                          onDelete: () => _deleteTask(task),
                          onComplete: (completed) =>
                              _markTaskComplete(task, completed),
                          onEdit: () => _editTask(task),
                          onTap: () => _showTaskDetails(context, task),
                        );
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildAddTaskButton(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: isDarkMode
            ? const Color.fromARGB(255, 37, 35, 42)
            : const Color.fromARGB(255, 227, 222, 229),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: _showAddTaskDialog,
          child: SizedBox(
            height: 66.0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,
                      color: isDarkMode
                          ? const Color.fromARGB(255, 247, 242, 249)
                          : const Color.fromARGB(255, 37, 35, 42)),
                  const SizedBox(width: 8.0),
                  Text(
                    'Add Task',
                    style: TextStyle(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 247, 242, 249)
                          : const Color.fromARGB(255, 37, 35, 42),
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddTaskDialog() async {
    _titleController.clear();
    _contentController.clear();
    _selectedDueDate = null;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  minWidth: 400, maxWidth: 400), // Set maximum width
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    maxLength: 75, // Limit title to 100 characters
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(labelText: 'Content'),
                    minLines: 1, // Min 1 lines
                    maxLines: 5, // Limit content to 5 lines
                  ),
                  const SizedBox(height: 8), // Add spacing
                  DropdownSearch<String>(
                    dropdownSearchDecoration:
                        const InputDecoration(labelText: 'Due Date'),
                    items: _generateDueDateItems(), // Generate dropdown items
                    selectedItem: _selectedDueDate,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedDueDate = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => _submit(context, null),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Submit'),
              ),
            ),
          ],
        );
      },
    );
  }

  List<String> _generateDueDateItems() {
    return [
      'Undecided',
      '30 minutes',
      '1 hour',
      '3 hours',
      '6 hours',
      '12 hours',
      '1 day',
      '2 days',
      '3 days',
      '1 week',
      '2 weeks',
      '1 month',
      // Add more options as needed
    ];
  }

  Future<void> _submit(BuildContext context, Task? existingTask) async {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();
    final String? dueDate = _selectedDueDate;

    if (existingTask != null) {
      existingTask.title = title;
      existingTask.content = content;
      existingTask.dueDate = dueDate; // Update due date
      await widget.taskService.updateTask(existingTask);

      // Update the task list and rebuild the UI with the updated list
      setState(() {
        final index = _tasks.indexWhere((t) => t.taskID == existingTask.taskID);
        if (index != -1) {
          _tasks[index] = existingTask;
        }
      });
    } else {
      final Task newTask = Task(
        title: title,
        content: content,
        dueDate: dueDate,
        userId: widget.userId,
      );

      int taskId = await widget.taskService.addTask(newTask, widget.userId);
      newTask.taskID = taskId;
      setState(() {
        _tasks.add(newTask); // Add the new task to the task list
      });
    }

    _titleController.clear();
    _contentController.clear();
    _selectedDueDate = null;
    Navigator.pop(context); // Close the dialog

    // Call _startCountdownTimer for new or existing task after 5 seconds
    Timer(const Duration(seconds: 5), () {
      if (existingTask != null) {
        _startOrResumeCountdownTimer(existingTask);
      } else {
        final Task newTask = Task(
          title: title,
          content: content,
          dueDate: dueDate,
          userId: widget.userId,
        );
        _startOrResumeCountdownTimer(newTask);
      }
    });
  }

  Future<void> _editTask(Task task) async {
    _titleController.text = task.title;
    _contentController.text = task.content;
    _selectedDueDate = task.dueDate;

    final updatedTask = await showDialog<Task>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(minWidth: 400, maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration:
                        const InputDecoration(labelText: 'Title (optional)'),
                    maxLength: 50,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(labelText: 'Content'),
                    minLines: 1,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 8),
                  DropdownSearch<String>(
                    dropdownSearchDecoration:
                        const InputDecoration(labelText: 'Due Date'),
                    items: _generateDueDateItems(),
                    selectedItem: _selectedDueDate,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedDueDate = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => _submit(context, task),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Submit'),
              ),
            ),
          ],
        );
      },
    );

    if (updatedTask != null) {
      // Update the task list and rebuild the UI with the updated list
      setState(() {
        final index = _tasks.indexWhere((t) => t.taskID == updatedTask.taskID);
        if (index != -1) {
          _tasks[index] = updatedTask;
        }
      });

      // Restart the countdown timer for the updated task
      _startOrResumeCountdownTimer(updatedTask);
    }
  }

  Future<void> _deleteTask(Task task) async {
    bool confirmDelete = false; // Default value

    // Show dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                // Dismiss dialog and set confirmDelete to false
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Dismiss dialog and set confirmDelete to true
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    ).then((value) {
      // Handle result from dialog
      if (value != null && value is bool) {
        confirmDelete = value;
      }
    });

    // Proceed with deletion if confirmDelete is true
    if (confirmDelete) {
      // Delete task
      await widget.taskService.deleteTask(task.taskID!);
      setState(() {
        _tasks.remove(task);
      });
    }
  }

  Future<void> _markTaskComplete(Task task, bool completed) async {
    task.completed = completed;
    await widget.taskService.updateTask(task);

    setState(() {
      final index = _tasks.indexWhere((t) => t.taskID == task.taskID);
      if (index != -1) {
        _tasks[index].completed = completed;
      }
    });
  }

  Future<void> _showTaskDetails(BuildContext context, Task task) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(task.title),
          content: Text(task.content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _startCountdownTimer(Task task) {
    if (task.dueDate != 'Undecided') {
      final dueDateTime = _calculateDueDate(task.dueDate);
      final now = DateTime.now();
      final duration = dueDateTime.isAfter(now)
          ? dueDateTime.difference(now)
          : Duration.zero;

      // print('Starting countdown timer for task: ${task.title}');
      // print('Initial duration for task ${task.title}: $duration');

      // Start countdown timer
      _timers[task.taskID ?? -1] =
          Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          final now = DateTime.now();
          final dueDateTime = _calculateDueDate(task.dueDate);
          task.dueDate = _formatRemainingTime(now, dueDateTime);
          _remainingTime[task.taskID ?? -1] = dueDateTime.isAfter(now)
              ? dueDateTime.difference(now)
              : Duration.zero;

          // print('Current time: $now');
          // print('Remaining time for task ${task.title}: $_remainingTime');
        });

        // Update the task with the new due date
        widget.taskService.updateTask(task);
      });

      // Store the initial remaining time
      _remainingTime[task.taskID ?? -1] = duration;

      // Update the due date status immediately
      if (duration == Duration.zero) {
        // Task is already overdue
        _markTaskComplete(task, false);
      }
    }
  }

  String _formatRemainingTime(DateTime now, DateTime dueDateTime) {
    final remainingTimeInSeconds =
        dueDateTime.isAfter(now) ? dueDateTime.difference(now).inSeconds : 0;

    final hours = remainingTimeInSeconds ~/ 3600;
    final minutes = (remainingTimeInSeconds ~/ 60) % 60;
    final seconds = remainingTimeInSeconds % 60;

    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  DateTime _calculateDueDate(String? dueDate) {
    final now = DateTime.now();
    if (dueDate == null || dueDate == 'Undecided') {
      return now;
    } else {
      // Check if the due date string contains ":" to determine the format
      if (dueDate.contains(':')) {
        // If ":" is present, split the string at ":" and parse the parts
        final parts = dueDate.split(':');
        if (parts.length != 3) {
          throw FormatException('Invalid due date format: $dueDate');
        }
        final hours = int.tryParse(parts[0]);
        final minutes = int.tryParse(parts[1]);
        final seconds = int.tryParse(parts[2]);
        if (hours == null || minutes == null || seconds == null) {
          throw FormatException('Invalid format in due date: $dueDate');
        }
        return now
            .add(Duration(hours: hours, minutes: minutes, seconds: seconds));
      } else {
        // If ":" is not present, treat it as the original format
        final parts = dueDate.split(' ');
        if (parts.length != 2) {
          throw FormatException('Invalid due date format: $dueDate');
        }
        final quantity = int.tryParse(parts[0]);
        if (quantity == null) {
          throw FormatException('Invalid quantity in due date: ${parts[0]}');
        }
        final unit = parts[1];
        if (unit == 'minute' || unit == 'minutes') {
          return now.add(Duration(minutes: quantity));
        } else if (unit == 'hour' || unit == 'hours') {
          return now.add(Duration(hours: quantity));
        } else if (unit == 'day' || unit == 'days') {
          return now.add(Duration(days: quantity));
        } else if (unit == 'week' || unit == 'weeks') {
          return now.add(Duration(days: quantity * 7));
        } else if (unit == 'month' || unit == 'months') {
          return DateTime(now.year, now.month + quantity, now.day, now.hour,
              now.minute, now.second, now.millisecond, now.microsecond);
        } else {
          throw FormatException('Invalid unit in due date: $unit');
        }
      }
    }
  }

  void _startOrResumeCountdownTimer(Task task) {
    if (!_timers.containsKey(task.taskID)) {
      // Start countdown timer only if it's not already running
      _startCountdownTimer(task);
    } else {
      // Timer exists, do nothing (timer is already running)
    }
  }

  // Map to store timers for each task
  final Map<int, Timer> _timers = {};

  @override
  void dispose() {
    for (final timer in _timers.values) {
      timer.cancel(); // Cancel all timers when the screen is disposed
    }
    super.dispose();
  }
}
