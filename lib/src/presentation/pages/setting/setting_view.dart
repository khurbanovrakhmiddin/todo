import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pharm/l10n/app_localizations.dart';

import '../../../../l10n/cubit/localization_cubit.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [LanguageSelector(), ThemeSelector()],
        ),
      ),
      appBar: AppBar(title: Text(loc.settings_tab)),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем текущую тему, чтобы кнопки выглядели гармонично
    final theme = Theme.of(context);

    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return SegmentedButton<Locale>(
          // Убираем стандартные рамки, если хотим более кастомный вид
          style: SegmentedButton.styleFrom(
            selectedBackgroundColor: theme.colorScheme.primary,
            selectedForegroundColor: theme.colorScheme.onPrimary,
            side: BorderSide(color: Colors.white10),
          ),
          segments: const [
            ButtonSegment(
              value: Locale('ru'),
              label: Text('Русский'),
              icon: Icon(Icons.language),
            ),
            ButtonSegment(value: Locale('uz'), label: Text('O‘zbek')),
            ButtonSegment(value: Locale('en'), label: Text('English')),
          ],
          selected: {state.locale},
          onSelectionChanged: (Set<Locale> newSelection) {
            print(newSelection.first);
            context.read<AppSettingsCubit>().setLocale(newSelection.first);
          },
          // Отключаем возможность оставить 0 выбранных элементов
          emptySelectionAllowed: false,
        );
      },
    );
  }
}

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!; // Если используете l10n

    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return SegmentedButton<ThemeMode>(
          style: SegmentedButton.styleFrom(
            // Оптимизация под тему: используем цвета из ColorScheme
            selectedBackgroundColor: theme.colorScheme.primary,
            selectedForegroundColor: theme.colorScheme.onPrimary,
            backgroundColor: theme.colorScheme.surface,
          ),
          segments: [
            ButtonSegment(
              value: ThemeMode.system,
              label: Text(local.theme_system), // "Системная"
              icon: const Icon(Icons.settings_brightness),
            ),
            ButtonSegment(
              value: ThemeMode.light,
              label: Text(local.theme_light), // "Светлая"
              icon: const Icon(Icons.light_mode),
            ),
            ButtonSegment(
              value: ThemeMode.dark,
              label: Text(local.theme_dark), // "Темная"
              icon: const Icon(Icons.dark_mode),
            ),
          ],
          selected: {state.themeMode},
          onSelectionChanged: (Set<ThemeMode> newSelection) {
            context.read<AppSettingsCubit>().setTheme(newSelection.first);
          },
        );
      },
    );
  }
}
