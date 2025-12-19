import 'package:it_pharm/src/domain/entities/note_entity.dart';

import '../repository/note_repo.dart';

class EditNotesUseCase {
  final NoteRepository repository;

  EditNotesUseCase(this.repository);

  Future<int> call(NoteEntity note) async {
    return await repository.editNote(note);
  }
}
