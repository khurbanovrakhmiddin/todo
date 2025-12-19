import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../state/cubit/note_action_cubit.dart';

class ImageFromGallery extends StatelessWidget {
  const ImageFromGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteActionCubit>();
    return BlocBuilder<NoteActionCubit, NoteActionState>(
      buildWhen: (prev, cur) => prev.photos.length != cur.photos.length,
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.photo_library),
          onPressed: () => cubit.pickImage(ImageSource.gallery),
        );
      },
    );
  }
}
