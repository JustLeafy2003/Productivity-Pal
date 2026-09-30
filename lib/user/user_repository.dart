import 'user_object.dart';
import '../authentication/authentication_service.dart';
import '../database.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final AuthenticationService _authService;
  UserRepository(this._authService);
  final DatabaseManager _databaseManager = DatabaseManager();

  Future<void> updateUserName(User user, String newUsername) async {
    final String? loggedInUsername = await _authService.getName();
    if (loggedInUsername != null) {
      final Database db = await _databaseManager.initializeDatabase();
      final List<Map<String, dynamic>> result = await db.query(
        'user',
        where: 'user_id = ?',
        whereArgs: [user.userId],
      );
      if (result.isNotEmpty) {
        final String currentUsername = result.first['username'] as String;
        if (currentUsername == loggedInUsername) {
          await db.update(
            'user',
            {'username': newUsername},
            where: 'user_id = ?',
            whereArgs: [user.userId],
          );
          user.setUsername = newUsername;
        } else {
          throw Exception('Username must remain the same');
        }
      }
    }
  }

  Future<void> updateUserBio(User user, String newBio) async {
    final String? loggedInUsername = await _authService.getName();
    if (loggedInUsername != null) {
      final Database db = await _databaseManager.initializeDatabase();
      final List<Map<String, dynamic>> result = await db.query(
        'user',
        where: 'user_id = ?',
        whereArgs: [user.userId],
      );
      if (result.isNotEmpty) {
        final String currentUsername = result.first['username'] as String;
        if (currentUsername == loggedInUsername) {
          await db.update(
            'user',
            {'bio': newBio},
            where: 'user_id = ?',
            whereArgs: [user.userId],
          );
          user.setBio = newBio;
        } else {
          throw Exception('Username must remain the same');
        }
      }
    }
  }

  Future<String?> getUsername(int userId) async {
    final String? loggedInUsername = await _authService.getName();
    return loggedInUsername ?? '';
  }

  Future<String?> getBio(int userId) async {
    final String? loggedInUsername = await _authService.getName();

    if (loggedInUsername != null) {
      final Database db = await _databaseManager.initializeDatabase();
      final List<Map<String, dynamic>> result = await db.query(
        'user',
        where: 'username = ?',
        whereArgs: [loggedInUsername],
      );
      if (result.isNotEmpty) {
        final bio = result.first['bio'] as String?;
        return bio ?? '';
      }
    }

    return '';
  }

  Future<int?> getId() async {
    final String? loggedInUsername = await _authService.getName();

    if (loggedInUsername != null) {
      final Database db = await _databaseManager.initializeDatabase();
      final List<Map<String, dynamic>> result = await db.query(
        'user',
        where: 'username = ?',
        whereArgs: [loggedInUsername],
      );
      if (result.isNotEmpty) {
        final int? userId = result.first['user_id'] as int?;
        return userId;
      }
    }

    return null;
  }

  Future<bool> isUsernameUnique(String username) async {
    final Database db = await _databaseManager.initializeDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isEmpty; // If result is empty, username is unique
  }
}
