import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pharm/l10n/app_localizations.dart';

import '../cubit/app_tab_cubit.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocBuilder<AppTabCubit, AppTabState>(
      buildWhen: (prev, cur) => prev.index != cur.index,
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: context.read<AppTabCubit>().changeTab,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled, color: Colors.teal),
              label: loc.home_tab,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              activeIcon: Icon(Icons.settings_outlined, color: Colors.teal),
              label: loc.settings_tab,
            ),
          ],
        );
      },
    );
  }
}
