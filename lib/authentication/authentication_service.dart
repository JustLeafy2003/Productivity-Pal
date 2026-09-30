import 'authentication_repository.dart';

class AuthenticationService {
  final AuthenticationRepository _authRepository;

  AuthenticationService(this._authRepository);

  Future<void> signUp(String username, String password) async {
    await _authRepository.signUp(username, password);
  }

  Future<bool> signIn(String username, String password) async {
    bool success = await _authRepository.signIn(username, password);

    if (success) {
      // Update is_signed_in status in the repository
      await _authRepository.updateSignedInStatus(username, true);
    }

    return success;
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  Future<bool> isSignedIn() async {
    return await _authRepository.isSignedIn();
  }

  Future<String?> getName() async {
    return await _authRepository.getLoggedInUsername();
  }

  Future<String?> getBio() async {
    return await _authRepository.getBio();
  }
}
