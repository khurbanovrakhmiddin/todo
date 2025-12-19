import 'package:get_it/get_it.dart';
import 'package:it_pharm/src/data/repository/note_repo_impl.dart';
import 'package:it_pharm/src/data/request/local/local_ds.dart';
import 'package:it_pharm/src/domain/repository/note_repo.dart';
import 'package:it_pharm/src/domain/usecase/add_note_usecase.dart';
import 'package:it_pharm/src/domain/usecase/delete_note_usecase.dart';
import 'package:it_pharm/src/domain/usecase/edit_note_usecase.dart';
import 'package:it_pharm/src/domain/usecase/get_note_usecase.dart';
import 'package:it_pharm/src/presentation/pages/home/bloc/home_bloc.dart';
import 'package:it_pharm/src/services/audio_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<DatabaseService>(() => DatabaseService.instance);

  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(sl<DatabaseService>()),
  );

  sl.registerLazySingleton<AudioPlayerService>(() => AudioPlayerService());
  sl.registerLazySingleton(() => GetNotesUseCase(sl<NoteRepository>()));
  sl.registerLazySingleton(() => AddNoteUseCase(sl<NoteRepository>()));
  sl.registerLazySingleton(() => DeleteNotesUseCase(sl<NoteRepository>()));
  sl.registerLazySingleton(() => EditNotesUseCase(sl<NoteRepository>()));

  sl.registerFactory(
    () => HomeBloc(
      getNotesUseCase: sl<GetNotesUseCase>(),
      addNoteUseCase: sl<AddNoteUseCase>(),
      deleteNoteUseCase: sl<DeleteNotesUseCase>(),
      editNoteUseCase: sl<EditNotesUseCase>(),
    ),
  );
}
