import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
 import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
 import '../../../../../domain/entities/note_entity.dart';

part 'note_action_state.dart';

class NoteActionCubit extends Cubit<NoteActionState> {
  final NoteEntity? initialNote;
  final NoteAction type;
  final AudioRecorder _recorder = AudioRecorder();
  final ImagePicker _picker = ImagePicker();
  Timer? _timer;

  NoteActionCubit({this.initialNote, this.type = NoteAction.init})
      : super(
    initialNote != null
        ? NoteActionState(
      noteAction: type,
      title: initialNote.title,
      subtitle: initialNote.subtitle,
      photos: initialNote.photos,
      audios: initialNote.audios,
    )
        : const NoteActionState(),
  );

  void titleChanged(String value) => emit(state.copyWith(title: value));
  void subtitleChanged(String value) => emit(state.copyWith(subtitle: value));

  Future<void> pickImage(ImageSource source) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      status = await Permission.photos.request();
    }

    if (status.isDenied || status.isPermanentlyDenied) {
      if (status.isPermanentlyDenied) await openAppSettings();
      return;
    }

    if (status.isGranted || status.isLimited) {
      final XFile? file = await _picker.pickImage(source: source, imageQuality: 80);
      if (file != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final String fileName = "${DateTime.now().millisecondsSinceEpoch}_${p.basename(file.path)}";
        final String localPath = p.join(appDir.path, fileName);
        final File savedImage = await File(file.path).copy(localPath);
        final updatedPhotos = List<String>.from(state.photos)..add(savedImage.path);
        emit(state.copyWith(photos: updatedPhotos));
      }
    }
  }

  void removePhoto(int index) {
    if (state.noteAction == NoteAction.show) return;
    try {
      final path = state.photos[index];
      final file = File(path);
      if (file.existsSync()) file.deleteSync();
    } catch (e) {
      debugPrint(e.toString());
    }
    final updatedPhotos = List<String>.from(state.photos)..removeAt(index);
    emit(state.copyWith(photos: updatedPhotos));
  }

  Future<void> toggleRecording() async {
    if (state.isRecording) {
      await _stopAndSave();
    } else {
      var status = await Permission.microphone.status;
      if (status.isDenied) status = await Permission.microphone.request();
      if (status.isPermanentlyDenied) {
        await openAppSettings();
        return;
      }
      if (status.isGranted) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = "${DateTime.now().millisecondsSinceEpoch}.m4a";
        final fullPath = p.join(appDir.path, fileName);
        await _recorder.start(const RecordConfig(), path: fullPath);
        emit(state.copyWith(isRecording: true, recordingDuration: 0));
        _timer?.cancel();
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (state.recordingDuration >= 59) {
            _stopAndSave();
          } else {
            emit(state.copyWith(recordingDuration: state.recordingDuration + 1));
          }
        });
      }
    }
  }

  Future<void> _stopAndSave() async {
    _timer?.cancel();
    if (!state.isRecording) return;
    final path = await _recorder.stop();
    if (path != null) {
      final updatedAudios = List<String>.from(state.audios)..add(path);
      emit(state.copyWith(audios: updatedAudios, isRecording: false, recordingDuration: 0));
    }
  }

  Future<void> deleteAudio(String path) async {
    if (state.noteAction == NoteAction.show) return;
    try {
      final file = File(path);
      if (await file.exists()) await file.delete();
    } catch (e) {
      debugPrint(e.toString());
    }
    final updatedAudios = List<String>.from(state.audios)..removeWhere((e) => e == path);
    emit(state.copyWith(audios: updatedAudios));
  }

  Future<void> shareNote() async {

  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _recorder.dispose();
    return super.close();
  }
}