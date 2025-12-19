import '../entities/note_entity.dart';
import '../repository/note_repo.dart';

class AddNoteUseCase {
  final NoteRepository repository;
  AddNoteUseCase(this.repository);

  Future<void> call(NoteEntity note) async {
    return await repository.saveNote(note);
  }
}
