import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/audio_service.dart';
import '../state/audio_cubit/audio_cubit.dart';
import '../state/cubit/note_action_cubit.dart';

class AudioPlayerWidget extends StatelessWidget {
  final String path;

  const AudioPlayerWidget({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    final fileName = path.split('/').last;

    final bool canDelete =
        context.read<NoteActionCubit>().type != NoteAction.show;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: BlocProvider(
          create: (_) => AudioPlayerCubit(AudioPlayerService(), path),
          child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
            builder: (context, state) {
              final cubit = context.read<AudioPlayerCubit>();
              final double maxVal = state.duration.inMilliseconds.toDouble();
              final double currVal = state.position.inMilliseconds.toDouble();

              return Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          state.isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                        onPressed: cubit.playPause,
                      ),
                      if (canDelete)
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () async {
                            await cubit.stop();
                            if (context.mounted) {
                              context.read<NoteActionCubit>().deleteAudio(path);
                            }
                          },
                        ),
                      Expanded(
                        child: Slider(
                          max: maxVal > 0 ? maxVal : 1.0,
                          value: currVal.clamp(0, maxVal > 0 ? maxVal : 1.0),
                          onChanged: maxVal > 0 ? (v) => cubit.seek(v) : null,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(fileName, overflow: TextOverflow.ellipsis),
                      ),
                      Text("${_f(state.position)} / ${_f(state.duration)}"),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _f(Duration d) =>
      "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";
}
