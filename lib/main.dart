import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:it_pharm/src/presentation/pages/home/bloc/home_bloc.dart';
import 'package:it_pharm/src/presentation/pages/main/cubit/app_tab_cubit.dart';
import 'package:it_pharm/src/presentation/pages/main/main_page.dart';

import 'l10n/app_localizations.dart';
import 'l10n/cubit/localization_cubit.dart';
import 'sl.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppSettingsCubit()),
        BlocProvider(create: (_) => AppTabCubit()),
        BlocProvider(create: (_) => sl<HomeBloc>()..add(GetNotesEvent())),
      ],
      child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, state) {
          print("state.locale${state.locale}");
          return MaterialApp(
            scaffoldMessengerKey: scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: 'Pharm IT',
            locale: state.locale,
            supportedLocales: const [Locale('ru'), Locale('uz'), Locale('en')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            themeMode: state.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blueAccent,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blueAccent,
              brightness: Brightness.dark,
            ),
            home: MainPage(),
          );
        },
      ),
    );
  }
}
