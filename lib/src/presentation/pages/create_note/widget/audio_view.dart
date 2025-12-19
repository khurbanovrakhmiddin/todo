import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pharm/src/presentation/pages/create_note/widget/audio_player_widget.dart';

import '../state/cubit/note_action_cubit.dart';

class AudiosListView extends StatelessWidget {
  const AudiosListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteActionCubit, NoteActionState>(
      builder: (context, state) {
        return Column(
          children: state.audios.map((path) {
            return AudioPlayerWidget(path: path);
          }).toList(),
        );
      },
    );
  }
}
