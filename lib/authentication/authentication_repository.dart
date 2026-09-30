import '../database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  final DatabaseManager _databaseManager = DatabaseManager();

  Future<void> signUp(String username, String password) async {
    final Database db = await _databaseManager.initializeDatabase();
    await db.insert('user',
        {'username': username, 'password': password, 'is_signed_in': 1});
    // Simulate token generation by storing a dummy token in SharedPreferences
    // await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', 'dummy_token');
  }

  Future<bool> signIn(String username, String password) async {
    final Database db = await _databaseManager.initializeDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    // print('Sign-in query result: $result');
    if (result.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', 'dummy_token');

      // Check the previous value of is_signed_in
      // final List<Map<String, dynamic>> previousResult =
      await db.query(
        'user',
        where: 'username = ?',
        whereArgs: [username],
      );
      // print('Previous signed-in status query result: $previousResult');

      await updateSignedInStatus(username, true); // Update the flag
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    final Database db = await _databaseManager.initializeDatabase();
    String? username = await getLoggedInUsername();

    // Update the is_signed_in value to 0
    if (username != null) {
      try {
        await updateSignedInStatus(username, false); // Update the flag
        // int rowsAffected =
        await db.update(
          'user',
          {'is_signed_in': 0},
          where: 'username = ?',
          whereArgs: [username],
        );
        // print('Number of rows updated: $rowsAffected');
      } catch (e) {
        // print('Error updating signed-in status: $e');
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> isSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  Future<String?> getLoggedInUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      final Database db = await _databaseManager.initializeDatabase();
      final List<Map<String, dynamic>> result = await db.query(
        'user',
        where: 'is_signed_in = ?',
        whereArgs: [1],
      );
      if (result.isNotEmpty) {
        return result.first['username'];
      }
    }
    return null;
  }

  Future<String?> getBio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      final Database db = await _databaseManager.initializeDatabase();
      final List<Map<String, dynamic>> result = await db.query(
        'user',
        where: 'is_signed_in = ?',
        whereArgs: [1],
      );
      if (result.isNotEmpty) {
        return result.first['bio'];
      }
    }
    return null;
  }

  Future<void> updateSignedInStatus(String? username, bool isSignedIn) async {
    final Database db = await _databaseManager.initializeDatabase();
    // final List<Map<String, dynamic>> result =
    await db.query(
      'user',
      where: 'username = ?',
      whereArgs: [username],
    );

    // print('Update signed-in status query result: $result');
    // Update the is_signed_in column
    await db.update(
      'user',
      {'is_signed_in': isSignedIn ? 1 : 0},
      where: 'username = ?',
      whereArgs: [username],
    );
  }
}
