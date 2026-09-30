import 'package:flutter/material.dart';
import 'dart:async';
import 'task_object.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final VoidCallback onDelete;
  final Function(bool) onComplete;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onDelete,
    required this.onComplete,
    required this.onEdit,
    required this.onTap,
  }) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Timer? _timer;
  int? _remainingTimeInSeconds;

  @override
  void initState() {
    super.initState();
    if (widget.task.dueDate != null) {
      _initializeTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeTimer() {
    _remainingTimeInSeconds = _calculateRemainingTimeInSeconds();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTimeInSeconds = _remainingTimeInSeconds! - 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Theme.of(context).cardColor,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            decoration: widget.task.completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        SizedBox(
                          height: 100,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.task.content,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    decoration: widget.task.completed
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              Positioned(
                left: 8.0,
                bottom: 40.0,
                child: Text(
                  _formatRemainingTime(_remainingTimeInSeconds),
                  style: const TextStyle(fontSize: 12.0),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: widget.onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        widget.onComplete(!widget.task.completed);
                      },
                      color: widget.task.completed ? Colors.green : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: widget.onDelete,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // double _calculateContentHeight(BuildContext context) {
  //   final cardHeight = MediaQuery.of(context).size.height;
  //   final appBarHeight = AppBar().preferredSize.height;
  //   final statusBarHeight = MediaQuery.of(context).padding.top;
  //   final availableHeight = cardHeight -
  //       appBarHeight -
  //       statusBarHeight -
  //       8.0 * 2 -
  //       4.0 * 2 -
  //       8.0 * 2;
  //   const titleHeight = 24.0;
  //   const buttonHeight = 500.0;
  //   const buttonSpacing = 8.0;
  //   const footerHeight = buttonHeight + buttonSpacing * 2;

  //   // Calculate the minimum content height to avoid negative values
  //   const minimumContentHeight = 80.0 + titleHeight + footerHeight;

  //   // Ensure that the available height is at least the minimum content height
  //   final adjustedAvailableHeight = availableHeight < minimumContentHeight
  //       ? minimumContentHeight
  //       : availableHeight;

  //   return adjustedAvailableHeight - titleHeight - footerHeight;
  // }

  String _formatRemainingTime(int? remainingTimeInSeconds) {
    if (remainingTimeInSeconds == null || remainingTimeInSeconds <= 0) {
      return 'Overdue'; // Add a message for overdue tasks
    }
    final hours = remainingTimeInSeconds ~/ 3600;
    final minutes = (remainingTimeInSeconds ~/ 60) % 60;
    final seconds = remainingTimeInSeconds % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  int _calculateRemainingTimeInSeconds() {
    final dueDateTime = _calculateDueDate(widget.task.dueDate);
    final now = DateTime.now();
    return dueDateTime.isAfter(now)
        ? dueDateTime.difference(now).inSeconds
        : 0; // Return 0 if already overdue
  }

  DateTime _calculateDueDate(String? dueDate) {
    final now = DateTime.now();
    if (dueDate == null || dueDate == 'Undecided') {
      return now;
    } else {
      if (dueDate.contains(':')) {
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
          return DateTime(now.year, now.month + quantity, now.day);
        } else {
          throw FormatException('Unsupported unit in due date: $unit');
        }
      }
    }
  }
}
