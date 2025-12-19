import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/cubit/note_action_cubit.dart';

class PhotosListView extends StatelessWidget {
  const PhotosListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteActionCubit, NoteActionState>(
      builder: (context, state) {
        if (state.photos.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.photos.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            width: double.maxFinite,
                            height: MediaQuery.sizeOf(context).height * .7,
                            child: Image.file(
                              File(state.photos[index]),
                              fit: BoxFit.contain,
                              errorBuilder: (context, _, __) {
                                return Icon(Icons.error);
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(state.photos[index]),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (state.noteAction != NoteAction.show)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () =>
                            context.read<NoteActionCubit>().removePhoto(index),
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
