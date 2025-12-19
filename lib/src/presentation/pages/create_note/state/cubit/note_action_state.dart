part of 'note_action_cubit.dart';

enum NoteAction { init, edit, show }

class NoteActionState extends Equatable {

  final int recordingDuration;


   final NoteAction noteAction;
  final String title;
  final String subtitle;
  final List<String> photos;
  final List<String> audios;
  final bool isRecording;
  final bool isSaving;

  const NoteActionState({
    this.title = '',
    this.subtitle = '',
    this.recordingDuration = 0,
    this.noteAction = NoteAction.init,
    this.photos = const [],
    this.audios = const [],
    this.isRecording = false,
    this.isSaving = false,
  });

  NoteActionState copyWith({
    String? title,
    NoteAction? noteAction,
    int? recordingDuration,
    String? subtitle,
    List<String>? photos,
    List<String>? audios,
    bool? isRecording,
    bool? isSaving,
  }) {
    return NoteActionState(
      title: title ?? this.title,
      noteAction: noteAction ?? this.noteAction,
      subtitle: subtitle ?? this.subtitle,
      photos: photos ?? this.photos,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      audios: audios ?? this.audios,
      isRecording: isRecording ?? this.isRecording,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [
    title,
    subtitle,
    photos,
    audios,
    noteAction,
    isRecording,
    recordingDuration,
    isSaving,
  ];
}
