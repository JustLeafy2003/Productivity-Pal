import 'package:flutter/material.dart';
import 'user_object.dart';
import 'user_service.dart';

class UserScreen extends StatefulWidget {
  final int userId;
  final UserService userService;

  const UserScreen({
    Key? key,
    required this.userId,
    required this.userService,
  }) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late String _userId = '';
  late String _username = '';
  late String _bio = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    _userId = await widget.userService.getId();
    _username = await widget.userService.getUsername(widget.userId);
    _bio = await widget.userService.getBio(widget.userId);
    setState(() {});
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String _updatedUsername = _username;
        String _updatedBio = _bio;

        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller:
                    TextEditingController(text: _username), // Set initial value
                onChanged: (value) {
                  _updatedUsername = value;
                },
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'New Username',
                ),
              ),
              TextField(
                controller:
                    TextEditingController(text: _bio), // Set initial value
                onChanged: (value) {
                  _updatedBio = value;
                },
                maxLength: 255,
                decoration: const InputDecoration(
                  labelText: 'New Bio',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_updatedUsername.isNotEmpty || _updatedBio.isNotEmpty) {
                  final currentUsername =
                      await widget.userService.getUsername(widget.userId);
                  if (_updatedUsername != currentUsername) {
                    bool isUnique = await widget.userService
                        .isUsernameUnique(_updatedUsername);
                    if (!isUnique) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Username already exists. Please choose another one.'),
                        ),
                      );
                      return;
                    }
                  }
                  widget.userService.updateUserName(
                    User(userId: widget.userId),
                    _updatedUsername,
                  );
                  widget.userService.updateUserBio(
                    User(userId: widget.userId),
                    _updatedBio,
                  );
                  _username = _updatedUsername;
                  _bio = _updatedBio;
                  setState(() {});
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'User Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _UserCard(
                userId: _userId,
                username: _username,
                bio: _bio,
                onEditPressed: _editProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final String userId;
  final String username;
  final String bio;
  final VoidCallback onEditPressed;

  const _UserCard({
    required this.userId,
    required this.username,
    required this.bio,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final marginHorizontal = screenWidth > 600 ? screenWidth * 0.2 : 16.0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: 160),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.account_circle, size: 56),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(
                          text: 'ID: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: userId),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(
                          text: 'Username: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: username),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(
                          text: 'Bio: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: bio),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onEditPressed,
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
