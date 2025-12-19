import '../repository/note_repo.dart';

class DeleteNotesUseCase {
  final NoteRepository repository;

  DeleteNotesUseCase(this.repository);

  Future<int> call(int id) async {
    return await repository.deleteNote(id);
  }
}
