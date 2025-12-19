import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pharm/l10n/app_localizations.dart';
import 'package:it_pharm/src/services/share_service.dart';

import '../../domain/entities/note_entity.dart';
import '../../utils/time_parser.dart';
import '../pages/create_note/note_action_page.dart';
import '../pages/create_note/state/cubit/note_action_cubit.dart';
import '../pages/home/bloc/home_bloc.dart';

class NoteCard extends StatelessWidget {
  final NoteEntity note;

  const NoteCard({super.key, required this.note});

  void _showDeleteDialog(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(local.delete_note_title),
        content: Text(local.delete_note_confirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(local.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              context.read<HomeBloc>().add(DeleteNoteEvent(note.id!));
              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(local.note_deleted)));
            },
            child: Text(local.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: SizedBox(
        height: 150,
        child: GestureDetector(
          onLongPress: () => _showDeleteDialog(context),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                    NoteActionScreen(note: note, type: NoteAction.show),
              ),
            );
          },
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        note.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          await ShareService.shareNote(note);
                        },
                        icon: Icon(Icons.share),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Expanded(child: Text(note.subtitle, maxLines: 3)),
                  Wrap(
                    children: [
                      if (note.photos.isNotEmpty) Icon(Icons.image),
                      const SizedBox(width: 12),
                      if (note.audios.isNotEmpty) Icon(Icons.audio_file),
                      const SizedBox(width: 12),

                      Text(
                        TimeParser.time(
                          note.createdAt,
                          AppLocalizations.of(context)?.localeName,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
