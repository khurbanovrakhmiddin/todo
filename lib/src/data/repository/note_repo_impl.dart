import '../../domain/entities/note_entity.dart';
import '../../domain/repository/note_repo.dart';
import '../model/note_model.dart';
import '../request/local/local_ds.dart';

class NoteRepositoryImpl implements NoteRepository {
  final DatabaseService _dbService;

  NoteRepositoryImpl(this._dbService);

  @override
  Future<void> saveNote(NoteEntity note) async {
    final model = NoteModel.fromEntity(note);
    await _dbService.createNote(
      model.title,
      model.subtitle,
      model.photos,
      model.audios,
    );
  }

  @override
  Future<List<NoteEntity>> getNotes() async {
    final data = await _dbService.getAllNotes();
    return data.map((map) => NoteModel.fromJson(map)).toList();
  }

  @override
  Future<int> deleteNote(int id) async {
    return await _dbService.deleteNote(id);
  }

  @override
  Future<int> editNote(NoteEntity note) {
    // TODO: implement editNote
    throw UnimplementedError();
  }
}
