import 'package:it_pharm/src/domain/entities/note_entity.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
   static Future<void> shareNote(NoteEntity note) async {
    final String text = "${note.title}\n\n${note.subtitle}";

     final List<XFile> files = [
      ...note.photos.map((path) => XFile(path)),
      ...note.audios.map((path) => XFile(path)),
    ];

    if (files.isEmpty) {
       await SharePlus.instance.share(
        ShareParams(text: text, title: note.title, subject: note.title),
      );
    } else {
      await SharePlus.instance.share(
        ShareParams(
          files: files,
          text: text,
          title: note.title,
          subject: note.title,
        ),
      );
    }
  }
}
