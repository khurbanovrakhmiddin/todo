import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../state/cubit/note_action_cubit.dart';

class ImageFromCameraWidget extends StatelessWidget {
  const ImageFromCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteActionCubit>();
    return BlocBuilder<NoteActionCubit, NoteActionState>(
      buildWhen: (prev, cur) => prev.photos.length != cur.photos.length,
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () => cubit.pickImage(ImageSource.camera),
        );
      },
    );
    ;
  }
}
