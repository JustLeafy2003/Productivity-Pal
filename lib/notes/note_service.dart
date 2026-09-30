import 'note_object.dart';
import 'note_repository.dart';

class NoteService {
  final NoteRepository _noteRepository;

  NoteService(this._noteRepository);

  Future<List<Note>> getAllNotes(int userId) async {
    return await _noteRepository.getAllNotes(userId);
  }

  Future<void> addNote(Note note, int userId) async {
    await _noteRepository.insertNote(note, userId);
  }

  Future<void> deleteNote(int noteId) async {
    await _noteRepository.deleteNote(noteId);
  }

  Future<void> updateNote(Note note) async {
    await _noteRepository.updateNote(note);
  }
}
