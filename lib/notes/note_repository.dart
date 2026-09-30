import 'package:sqflite_common/sqlite_api.dart';
import 'note_object.dart';

class NoteRepository {
  final Database _database;

  NoteRepository(this._database);

  Future<List<Note>> getAllNotes(int userId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'note',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Note(
        noteID: maps[i]['note_id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
        creationDate: maps[i]['creation_date'],
        backgroundColor: maps[i]['background_color'],
        userId: userId,
      );
    });
  }

  Future<void> insertNote(Note note, int userId) async {
    await _database.insert(
      'note',
      {...note.toMap(), 'user_id': userId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteNote(int noteId) async {
    await _database.delete(
      'note',
      where: 'note_id = ?',
      whereArgs: [noteId],
    );
  }

  Future<void> updateNote(Note note) async {
    await _database.update(
      'note',
      note.toMap(),
      where: 'note_id = ?',
      whereArgs: [note.noteID],
    );
  }
}
