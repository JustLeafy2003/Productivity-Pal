import 'package:flutter/material.dart';
import 'tasks/task_screen.dart';
import 'notes/note_screen.dart';
import 'drawing/drawing_screen.dart';
import 'events/event_screen.dart';
import 'messages/message_screen.dart';
import 'tools/tool_screen.dart';
import 'user/user_screen.dart';
import 'authentication/authentication_service.dart';
import 'user/user_service.dart';
import 'tasks/task_service.dart';
import 'notes/note_service.dart';
import 'events/event_service.dart';
import 'unregistered_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  final AuthenticationService authService;
  final UserService userService;
  final TaskService taskService;
  final NoteService noteService;
  final EventService eventService;
  bool isDarkMode;

  HomeScreen({
    required this.authService,
    required this.userService,
    required this.taskService,
    required this.noteService,
    required this.eventService,
    required this.isDarkMode,
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late int _userId = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    final userId = await widget.userService.getId();
    setState(() {
      _userId = int.parse(userId); // Convert String to int
    });
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ThemeData _getTheme() {
    if (widget.isDarkMode) {
      return ThemeData.dark();
    } else {
      return ThemeData.light();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _getTheme(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: _onDestinationSelected,
                      labelType: NavigationRailLabelType.selected,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.task),
                          label: Text('Tasks'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.note),
                          label: Text('Notes'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.event),
                          label: Text('Events'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.message),
                          label: Text('Messages'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.draw),
                          label: Text('Drawing'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.build),
                          label: Text('Tools'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.person),
                          label: Text('User'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(
                      child: _selectedIndex == 0
                          ? _buildHomePageContent()
                          : _buildTabContent(_selectedIndex, _userId),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.isDarkMode
                      ? const Color.fromARGB(255, 28, 27, 31)
                      : const Color.fromARGB(255, 255, 252, 254),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    IconButton(
                      icon: widget.isDarkMode
                          ? const Icon(Icons.wb_sunny)
                          : const Icon(Icons.nightlight_round),
                      onPressed: () {
                        setState(() {
                          widget.isDarkMode = !widget.isDarkMode;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () async {
                        await widget.authService.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UnregisteredScreen(
                              authService: widget.authService,
                              userService: widget.userService,
                              taskService: widget.taskService,
                              noteService: widget.noteService,
                              eventService: widget.eventService,
                              isDarkMode: widget.isDarkMode,
                              userId: _userId,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomePageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Welcome to Productivity Pal!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Click on any of the buttons below to get started with your productivity needs.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildToolButton(
              Icons.task,
              'Tasks',
              'Keep track of your to-do list and manage tasks efficiently.',
              () {
                _onDestinationSelected(1);
              },
            ),
            _buildToolButton(
              Icons.note,
              'Notes',
              'Take some notes, jot down ideas, and stay organized.',
              () {
                _onDestinationSelected(2);
              },
            ),
            _buildToolButton(
              Icons.event,
              'Events',
              'Manage your events, appointments, and important dates.',
              () {
                _onDestinationSelected(3);
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildToolButton(
              Icons.message,
              'Messages',
              'Communicate with others through messages and chats.',
              () {
                _onDestinationSelected(4);
              },
            ),
            _buildToolButton(
              Icons.draw,
              'Drawing',
              'Unleash your creativity with drawing and sketching tools.',
              () {
                _onDestinationSelected(5);
              },
            ),
            _buildToolButton(
              Icons.build,
              'Tools',
              'Access various text tools, unit conversion tools, and math tools.',
              () {
                _onDestinationSelected(6);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToolButton(
      IconData icon, String title, String description, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: onTap,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 36.0,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(int index, int userId) {
    switch (index) {
      case 0:
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Productivity Pal!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Here will be a preview of your content.',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      case 1:
        return TaskScreen(
            userId: userId,
            userService: widget.userService,
            taskService: widget.taskService,
            isDarkMode: widget.isDarkMode);
      case 2:
        return NoteScreen(
            userId: userId,
            userService: widget.userService,
            noteService: widget.noteService,
            isDarkMode: widget.isDarkMode);
      case 3:
        return EventScreen(
            userId: userId,
            userService: widget.userService,
            eventService: widget.eventService,
            isDarkMode: widget.isDarkMode);
      case 4:
        return MessageScreen(userId: userId, userService: widget.userService);
      case 5:
        return DrawingScreen(
          userId: userId,
          userService: widget.userService,
          isDarkMode: widget.isDarkMode,
        );
      case 6:
        return ToolScreen(userId: userId, userService: widget.userService);
      case 7:
        return UserScreen(userId: userId, userService: widget.userService);
      default:
        return const Center(
          child: Text('Invalid Index'),
        );
    }
  }
}
