import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pharm/l10n/app_localizations.dart';
import 'package:it_pharm/src/presentation/pages/main/cubit/app_tab_cubit.dart';

import '../../home/bloc/home_bloc.dart';

class AppAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BlocBuilder<AppTabCubit, AppTabState>(
      buildWhen: (prev, cur) => prev.index != cur.index,
      builder: (context, state) {
        final int index = state.index;
        return AppBar(
          title: Text(index == 0 ? local.home_tab : local.settings_tab),
          actions: [
            if (index == 0)
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (prev, cur) => prev.isGridView != cur.isGridView,
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      state.isGridView ? Icons.view_list : Icons.grid_view,
                    ),
                    onPressed: () =>
                        context.read<HomeBloc>().add(ToggleViewModeEvent()),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
