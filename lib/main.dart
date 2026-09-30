import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'authentication/authentication_repository.dart';
import 'authentication/authentication_service.dart';
import 'tasks/task_repository.dart';
import 'tasks/task_service.dart';
import 'notes/note_repository.dart';
import 'notes/note_service.dart';
import 'events/event_repository.dart';
import 'events/event_service.dart';
import 'user/user_repository.dart';
import 'user/user_service.dart';
import 'unregistered_screen.dart';
import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  final DatabaseManager databaseManager = DatabaseManager();
  final Database database = await databaseManager.initializeDatabase();

// Initialize authentication service and repository
  final AuthenticationService authService =
      AuthenticationService(AuthenticationRepository());

// Initialize task repository and service
  final TaskRepository taskRepository = TaskRepository(database);
  final TaskService taskService = TaskService(taskRepository);

// Initialize note repository and service
  final NoteRepository noteRepository = NoteRepository(database);
  final NoteService noteService = NoteService(noteRepository);

// Initialize event repository and service
  final EventRepository eventRepository = EventRepository(database);
  final EventService eventService = EventService(eventRepository);

// Initialize user repository and service
  final UserRepository userRepository = UserRepository(authService);
  final UserService userService = UserService(userRepository);

  // Run the app
  runApp(MyApp(
    authService: authService,
    userService: userService,
    taskService: taskService,
    noteService: noteService,
    eventService: eventService,
    isDarkMode: false, // Initial value for isDarkMode
    userId: 0, // Initial value for userId
  ));
}

class MyApp extends StatelessWidget {
  final AuthenticationService authService;
  final UserService userService;
  final TaskService taskService;
  final NoteService noteService;
  final EventService eventService;
  final bool isDarkMode;
  final int userId;

  const MyApp({
    required this.authService,
    required this.userService,
    required this.taskService,
    required this.noteService,
    required this.eventService,
    required this.isDarkMode,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UnregisteredScreen(
        authService: authService,
        userService: userService,
        taskService: taskService,
        noteService: noteService,
        eventService: eventService,
        isDarkMode: isDarkMode,
        userId: userId,
      ),
    );
  }
}
