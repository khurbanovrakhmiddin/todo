import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pharm/src/presentation/pages/create_note/state/cubit/note_action_cubit.dart';
import 'package:it_pharm/src/presentation/pages/create_note/widget/action_buttons/image_from_camera_widget.dart';
import 'package:it_pharm/src/presentation/pages/create_note/widget/action_buttons/image_from_gal_widget.dart';
import 'package:it_pharm/src/presentation/pages/create_note/widget/audio_view.dart';
import 'package:it_pharm/src/presentation/pages/create_note/widget/action_buttons/audio_widget.dart';
import 'package:it_pharm/src/presentation/pages/create_note/widget/photo_view.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../domain/entities/note_entity.dart';
import '../home/bloc/home_bloc.dart';

class NoteActionScreen extends StatelessWidget {
  final NoteEntity? note;
  final NoteAction type;

  const NoteActionScreen({super.key, this.note, this.type = NoteAction.init});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteActionCubit(initialNote: note, type: type),
      child: const NoteActionView(),
    );
  }
}

class NoteActionView extends StatelessWidget {
  const NoteActionView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final cubit = context.read<NoteActionCubit>();
    final isEditing = cubit.initialNote != null;
    final readOnly = cubit.type == NoteAction.show;

    return Scaffold(
      floatingActionButton: readOnly
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                ImageFromGallery(),
                SizedBox(width: 12),
                ImageFromCameraWidget(),
                SizedBox(width: 12),
                AudioWidget(),
              ],
            ),
      appBar: AppBar(
        title: Text(
          readOnly
              ? ""
              : isEditing
              ? local.edit_note
              : local.new_note,
        ),
        actions: [

          if (!readOnly)
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: () => _onSave(context, cubit),
            ),
        ],
      ),
      body: BlocBuilder<NoteActionCubit, NoteActionState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  readOnly: readOnly,
                  initialValue: state.title,
                  onChanged: cubit.titleChanged,
                  decoration: InputDecoration(labelText: local.title_label),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  readOnly: readOnly,
                  initialValue: state.subtitle,
                  onChanged: cubit.subtitleChanged,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: local.description_label,
                  ),
                ),
                const PhotosListView(),
                const AudiosListView(),
                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSave(BuildContext context, NoteActionCubit cubit) {
    final state = cubit.state;
    if (state.title.isEmpty) return;

    final noteToSave = NoteEntity(
      id: cubit.initialNote?.id,
      title: state.title,
      subtitle: state.subtitle,
      photos: state.photos,
      audios: state.audios,
      createdAt: cubit.initialNote?.createdAt ?? DateTime.now(),
    );

    if (cubit.initialNote != null) {
      context.read<HomeBloc>().add(UpdateNoteEvent(noteToSave));
    } else {
      context.read<HomeBloc>().add(AddNoteEvent(noteToSave));
    }
    Navigator.pop(context);
  }
}
