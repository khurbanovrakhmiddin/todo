import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  Stream<Duration> get onPositionChanged => _player.onPositionChanged;
  Stream<Duration> get onDurationChanged => _player.onDurationChanged;
  Stream<PlayerState> get onPlayerStateChanged => _player.onPlayerStateChanged;

  Future<void> setSource(String path) async {
    await _player.setSource(DeviceFileSource(path));
  }

  Future<void> play(String path) async {
    await _player.play(DeviceFileSource(path));
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  void dispose() {
    _player.dispose();
  }
}
