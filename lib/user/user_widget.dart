import 'package:flutter/material.dart';
import 'user_service.dart';

class UserWidget extends StatefulWidget {
  final int userId;
  final UserService userService;

  const UserWidget(
      {super.key, required this.userId, required this.userService});

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  late Future<String> _usernameFuture;
  late Future<String> _bioFuture;

  @override
  void initState() {
    super.initState();
    _usernameFuture = _getUsername();
    _bioFuture = _getBio();
  }

  Future<String> _getUsername() async {
    final String? loggedInUsername =
        await widget.userService.getUsername(widget.userId);
    if (loggedInUsername != null) {
      return loggedInUsername;
    }
    return widget.userService.getUsername(widget.userId);
  }

  Future<String> _getBio() async {
    final String? loggedInUsername =
        await widget.userService.getUsername(widget.userId);
    if (loggedInUsername != null) {
      return widget.userService.getBio(widget.userId);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_usernameFuture, _bioFuture]),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final username = snapshot.data?[0] ?? '';
          final bio = snapshot.data?[1] ?? '';
          return Column(
            children: [
              Text('Username: $username'),
              Text('Bio: $bio'),
            ],
          );
        }
      },
    );
  }
}
