part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class ToggleViewModeEvent extends HomeEvent {}

class GetNotesEvent extends HomeEvent {}

class AddNoteEvent extends HomeEvent {
  final NoteEntity note;
  const AddNoteEvent(this.note);
}

class UpdateNoteEvent extends HomeEvent {
  final NoteEntity note;
  const UpdateNoteEvent(this.note);
}

class DeleteNoteEvent extends HomeEvent {
  final int id;
  const DeleteNoteEvent(this.id);
}
