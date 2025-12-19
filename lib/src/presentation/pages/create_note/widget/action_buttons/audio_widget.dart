import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pharm/l10n/app_localizations.dart';

import '../../state/cubit/note_action_cubit.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BlocBuilder<NoteActionCubit, NoteActionState>(
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: () => context.read<NoteActionCubit>().toggleRecording(),
          icon: Icon(state.isRecording ? Icons.stop : Icons.mic),
          label: Text(
            "${state.isRecording ? local.stop : local.voice} ${state.recordingDuration == 0 ? '' : state.recordingDuration}",
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: state.isRecording ? Colors.red : null,
          ),
        );
      },
    );
    ;
  }
}
