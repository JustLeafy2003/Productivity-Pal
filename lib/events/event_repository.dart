import 'package:sqflite_common/sqlite_api.dart';
import 'event_object.dart';

class EventRepository {
  final Database _database;

  EventRepository(this._database);

  Future<List<CustomEvent>> getEvents(int userId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'event',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) {
      return CustomEvent(
        eventID: maps[i]['event_id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        userID: maps[i]['user_id'],
        year: maps[i]['year'],
        month: maps[i]['month'],
        day: maps[i]['day'],
      );
    });
  }

  Future<void> insertEvent(CustomEvent event, int userId) async {
    await _database.insert(
      'event',
      {...event.toMap(), 'user_id': userId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteEvent(int eventID) async {
    await _database.delete(
      'event',
      where: 'event_id = ?',
      whereArgs: [eventID],
    );
  }

  Future<void> updateEvent(CustomEvent event) async {
    await _database.update(
      'event',
      event.toMap(),
      where: 'event_id = ?',
      whereArgs: [event.eventID],
    );
  }
}
