import 'package:flutter/material.dart';
import 'authentication/authentication_service.dart';
import 'user/user_service.dart';
import 'tasks/task_service.dart';
import 'notes/note_service.dart';
import 'events/event_service.dart';
import 'authentication/sign_in_screen.dart';
import 'authentication/create_account_screen.dart';

class UnregisteredScreen extends StatelessWidget {
  final AuthenticationService authService;
  final UserService userService;
  final TaskService taskService;
  final NoteService noteService;
  final EventService eventService;
  final int userId;
  final bool isDarkMode;

  const UnregisteredScreen({
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
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.75,
          heightFactor: 0.75,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Welcome to Productivity Pal!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Productivity Pal is a multi-purpose productivity app that is designed to help with several productivity needs, all in a single app. To get started, create your account, or sign in if you already have one.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(
                                // Correct instantiation
                                authService: authService,
                                userService: userService,
                                taskService: taskService,
                                noteService: noteService,
                                eventService: eventService,
                                isDarkMode: isDarkMode,
                                userId: userId,
                              ),
                            ),
                          );
                        },
                        child: const Text('Sign In'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAccountScreen(
                                // Correct instantiation
                                authService: authService,
                                userService: userService,
                                taskService: taskService,
                                noteService: noteService,
                                eventService: eventService,
                                isDarkMode: isDarkMode,
                                userId: userId,
                              ),
                            ),
                          );
                        },
                        child: const Text('Create Account'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
