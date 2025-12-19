import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pharm/src/presentation/pages/main/cubit/app_tab_cubit.dart';
import 'package:it_pharm/src/presentation/pages/main/widget/app_appbar.dart';
import 'package:it_pharm/src/presentation/pages/main/widget/app_float_button.dart';
import 'package:it_pharm/src/presentation/pages/main/widget/navigation_bar.dart';

import '../home/home_view.dart';
import '../setting/setting_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(),
      floatingActionButton: AppFloatButton(),
      body: BlocBuilder<AppTabCubit, AppTabState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.index,
            children: [HomeView(), SettingView()],
          );
        },
      ),
      bottomNavigationBar: AppNavigationBar(),
    );
  }
}
