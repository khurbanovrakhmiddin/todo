import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pharm/src/domain/entities/note_entity.dart';
import 'package:it_pharm/src/presentation/pages/home/bloc/home_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../widget/note_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      child: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (prev, curr) => curr.status == HomeStatus.error,
        listener: (context, state) {
          if (state.errorMessage != null) {
            final local = AppLocalizations.of(context)!;

            String translatedError;
            switch (state.errorMessage) {
              case "error_get_notes":
                translatedError = local.error_get_notes;
                break;
              case "error_add_note":
                translatedError = local.error_add_note;
                break;
              case "error_delete_note":
                translatedError = local.error_delete_note;
                break;
              case "error_update_note":
                translatedError = local.error_update_note;
                break;
              default:
                translatedError = state.errorMessage!;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translatedError),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.notes.isEmpty) {
            return const Center(child: Text("Zametok poka netu"));
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: state.isGridView
                ? _buildGrid(state.notes)
                : _buildList(state.notes),
          );
        },
      ),
      onRefresh: () async {
        context.read<HomeBloc>().add(GetNotesEvent());
      },
    );
  }

  // Вид СПИСКОМ
  Widget _buildList(List<NoteEntity> notes) {
    return ListView.builder(
      key: const ValueKey('list_view'),
      padding: const EdgeInsets.all(8),
      itemCount: notes.length,
      itemBuilder: (context, index) => NoteCard(note: notes[index]),
    );
  }

  // Вид СЕТКОЙ
  Widget _buildGrid(List<NoteEntity> notes) {
    return GridView.builder(
      key: const ValueKey('grid_view'),
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) => NoteCard(note: notes[index]),
    );
  }
}
