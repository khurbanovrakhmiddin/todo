import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../services/audio_service.dart';

part 'audio_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayerService _service;
  final String filePath;
  StreamSubscription? _s1;
  StreamSubscription? _s2;
  StreamSubscription? _s3;

  AudioPlayerCubit(this._service, this.filePath)
    : super(const AudioPlayerState()) {
    _init();
    _s1 = _service.onPlayerStateChanged.listen(
      (s) => emit(state.copyWith(playerState: s)),
    );
    _s2 = _service.onPositionChanged.listen(
      (p) => emit(state.copyWith(position: p)),
    );
    _s3 = _service.onDurationChanged.listen(
      (d) => emit(state.copyWith(duration: d)),
    );
  }

  Future<void> _init() async {
    await _service.setSource(filePath);
  }

  void playPause() {
    state.isPlaying ? _service.pause() : _service.play(filePath);
  }

  void seek(double ms) => _service.seek(Duration(milliseconds: ms.toInt()));

  Future<void> stop() async => await _service.stop();

  @override
  Future<void> close() {
    _s1?.cancel();
    _s2?.cancel();
    _s3?.cancel();
    _service.dispose();
    return super.close();
  }
}
