import 'user_object.dart';
import 'user_repository.dart';

class UserService {
  final UserRepository userRepository;

  UserService(this.userRepository);

  Future<void> updateUserName(User user, String newUsername) async {
    await userRepository.updateUserName(user, newUsername);
  }

  Future<void> updateUserBio(User user, String newBio) async {
    await userRepository.updateUserBio(user, newBio);
  }

  Future<String> getUsername(int userId) async {
    return (await userRepository.getUsername(userId)) ?? '';
  }

  Future<String> getBio(int userId) async {
    return (await userRepository.getBio(userId)) ?? '';
  }

  Future<String> getId() async {
    final int? userId = await userRepository.getId();
    return userId?.toString() ?? '';
  }

  Future<bool> isUsernameUnique(String username) async {
    // Call the repository method to check if the username is unique
    return await userRepository.isUsernameUnique(username);
  }
}
