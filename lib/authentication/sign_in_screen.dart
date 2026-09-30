import 'package:flutter/material.dart';
import 'authentication_service.dart';
import '../home_screen.dart';
import '../user/user_service.dart';
import '../tasks/task_service.dart';
import '../notes/note_service.dart';
import '../events/event_service.dart';
import 'create_account_screen.dart'; // Import create account screen

class SignInScreen extends StatelessWidget {
  final AuthenticationService authService;
  final UserService userService;
  final TaskService taskService;
  final NoteService noteService;
  final EventService eventService;

  final bool isDarkMode;
  final int userId;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInScreen({
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
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
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
                    'Sign In',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (usernameController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Both username and password are required'),
                          ),
                        );
                      } else {
                        bool success = await authService.signIn(
                          usernameController.text,
                          passwordController.text,
                        );
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                authService: authService,
                                userService: userService,
                                taskService: taskService,
                                noteService: noteService,
                                eventService: eventService,
                                isDarkMode: isDarkMode,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid username or password'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 20),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAccountScreen(
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
                      child: const Text(
                        'Don\'t have an account? Create one',
                        style: TextStyle(
                          color: Color(0xff6750a4),
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
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
}
