import 'package:flutter/material.dart';
import '../user/user_service.dart';

class MessageScreen extends StatefulWidget {
  final int userId;
  final UserService userService;

  const MessageScreen({
    required this.userId,
    required this.userService,
    Key? key,
  }) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late Future<String> _idFuture;

  @override
  void initState() {
    super.initState();
    _idFuture = _getId();
  }

  Future<String> _getId() async {
    final String userId = await widget.userService.getId();
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Screen'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _idFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // final String userId = snapshot.data ?? '';
              return const Text('Coming soon!');
            }
          },
        ),
      ),
    );
  }
}
