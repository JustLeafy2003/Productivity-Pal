class User {
  int userId;
  String username;
  String password;
  String bio;

  User({
    required this.userId,
    this.username = '',
    this.password = '',
    this.bio = '',
  });

  set setUsername(String newUsername) {
    username = newUsername;
  }

  set setBio(String newBio) {
    bio = newBio;
  }
}
