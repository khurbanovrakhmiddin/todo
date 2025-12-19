part of 'audio_cubit.dart';

class AudioPlayerState extends Equatable {
  final PlayerState playerState;
  final Duration position;
  final Duration duration;

  const AudioPlayerState({
    this.playerState = PlayerState.stopped,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });

  bool get isPlaying => playerState == PlayerState.playing;

  AudioPlayerState copyWith({
    PlayerState? playerState,
    Duration? position,
    Duration? duration,
  }) {
    return AudioPlayerState(
      playerState: playerState ?? this.playerState,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object> get props => [playerState, position, duration];
}
