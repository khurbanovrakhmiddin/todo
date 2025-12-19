import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pharm/src/presentation/pages/main/cubit/app_tab_cubit.dart';
import 'package:flutter/material.dart';

import '../../create_note/note_action_page.dart';

class AppFloatButton extends StatefulWidget {
  const AppFloatButton({super.key});

  @override
  State<AppFloatButton> createState() => _AppFloatButtonState();
}

class _AppFloatButtonState extends State<AppFloatButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppTabCubit, AppTabState>(
      buildWhen: (prev, cur) => prev.index != cur.index,
      builder: (context, state) {
        final bool showButton = state.index == 0;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 250),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: showButton
              ? FloatingActionButton(
                  key: const ValueKey('fab_active'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const NoteActionScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : const SizedBox(
                  key: ValueKey('fab_hidden'),
                  width: 56,
                  height: 56,
                ),
        );
      },
    );
  }
}
