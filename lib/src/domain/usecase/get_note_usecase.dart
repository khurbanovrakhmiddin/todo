import '../entities/note_entity.dart';
import '../repository/note_repo.dart';

class GetNotesUseCase {
  final NoteRepository repository;

  GetNotesUseCase(this.repository);

  Future<List<NoteEntity>> call() async {
    return await repository.getNotes();
  }
}
