import '../entities/note_entity.dart';

abstract class NoteRepository {
  Future<void> saveNote(NoteEntity note);
  Future<int> editNote(NoteEntity note);

  Future<List<NoteEntity>> getNotes();

  Future<int> deleteNote(int id);
}
