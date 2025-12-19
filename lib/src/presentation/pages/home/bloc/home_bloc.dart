import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_pharm/src/domain/usecase/delete_note_usecase.dart';
import 'package:it_pharm/src/domain/usecase/edit_note_usecase.dart';

import '../../../../domain/entities/note_entity.dart';
import '../../../../domain/usecase/add_note_usecase.dart';
import '../../../../domain/usecase/get_note_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNotesUseCase getNotesUseCase;
  final AddNoteUseCase addNoteUseCase;
  final DeleteNotesUseCase deleteNoteUseCase;
  final EditNotesUseCase editNoteUseCase;

  HomeBloc({
    required this.getNotesUseCase,
    required this.addNoteUseCase,
    required this.deleteNoteUseCase,
    required this.editNoteUseCase,
  }) : super(const HomeState()) {
    on<GetNotesEvent>(_onGetNotes);
    on<AddNoteEvent>(_onAddNote);
    on<DeleteNoteEvent>(_onDeleteNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<ToggleViewModeEvent>((event, emit) {
      emit(state.copyWith(isGridView: !state.isGridView));
    });
  }

  Future<void> _onGetNotes(GetNotesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final notes = await getNotesUseCase.call();
      emit(state.copyWith(status: HomeStatus.success, notes: notes));
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: "error_get_notes",
        ),
      );
    }
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<HomeState> emit) async {
    try {
      await addNoteUseCase.call(event.note);
      add(GetNotesEvent());
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: "error_add_note",
        ),
      );
    }
  }

  Future<void> _onDeleteNote(
    DeleteNoteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await deleteNoteUseCase.call(event.id);
      add(GetNotesEvent());
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: "error_delete_note",
        ),
      );
    }
  }

  Future<void> _onUpdateNote(
    UpdateNoteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await editNoteUseCase.call(event.note);
      add(GetNotesEvent());
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: "error_update_note",
        ),
      );
    }
  }
}
