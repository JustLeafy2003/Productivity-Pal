import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DatabaseManager {
  Future<Database> initializeDatabase() async {
    databaseFactory = databaseFactoryFfi;

    final String path = await getDatabasesPath();
    final String databasePath = join(path, 'app_database.db');

    return openDatabase(
      databasePath, // Use the concatenated database path
      onCreate: (db, version) {
        return _createTables(db);
      },
      version: 1,
    );
  }

  Future<void> _createTables(Database db) async {
    try {
      await db.execute('''
        CREATE TABLE user (
          user_id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT NOT NULL,
          password TEXT NOT NULL,
          bio TEXT,
          is_signed_in INTEGER DEFAULT 0,
          CONSTRAINT user_id_unique UNIQUE (user_id) ON CONFLICT REPLACE
        )
      ''');

      await db.execute('''
        CREATE TABLE task (
          task_id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT,
          due_date TEXT,
          status TEXT,
          user_id INTEGER,
          FOREIGN KEY (user_id) REFERENCES user (user_id)
        )
      ''');

      await db.execute('''
        CREATE TABLE note (
            note_id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            creation_date TEXT,
            background_color TEXT,
            user_id INTEGER,
            FOREIGN KEY (user_id) REFERENCES user (user_id)
        )
      ''');

      await db.execute('''
        CREATE TABLE reminder (
          reminder_id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          reminder_date TEXT,
          status TEXT,
          user_id INTEGER,
          FOREIGN KEY (user_id) REFERENCES user (user_id)
        )
      ''');

      await db.execute('''
        CREATE TABLE event (
          event_id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          year TEXT,
          month TEXT,
          day TEXT,
          user_id INTEGER,
          FOREIGN KEY (user_id) REFERENCES user (user_id)
        )
      ''');

      await db.execute('''
        CREATE TABLE message (
          message_id INTEGER PRIMARY KEY AUTOINCREMENT,
          content TEXT,
          timestamp TEXT,
          user_id INTEGER,
          FOREIGN KEY (user_id) REFERENCES user (user_id)
        )
      ''');
      // print('Created tables');
    } catch (e) {
      // print('Error creating tables: $e');
      // Handle the error appropriately (e.g., display an error message, log the error, etc.)
    }
  }
}
