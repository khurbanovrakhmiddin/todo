// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get all => 'Все';

  @override
  String get home_tab => 'Главная';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get settings_tab => 'Настройки';

  @override
  String get theme_system => 'Система';

  @override
  String get theme_light => 'Светлая';

  @override
  String get theme_dark => 'Темная';

  @override
  String get delete_note_title => 'Удалить заметку?';

  @override
  String get delete_note_confirm => 'Вы уверены, что хотите безвозвратно удалить эту заметку и все прикрепленные медиафайлы?';

  @override
  String get delete => 'Удалить';

  @override
  String get cancel => 'Отмена';

  @override
  String get note_deleted => 'Заметка удалена';

  @override
  String get error_get_notes => 'Ошибка при получении заметок';

  @override
  String get error_add_note => 'Ошибка при добавлении';

  @override
  String get error_delete_note => 'Ошибка при удалении';

  @override
  String get error_update_note => 'Ошибка при обновлении';

  @override
  String get new_note => 'Новая заметка';

  @override
  String get edit_note => 'Редактировать';

  @override
  String get title_label => 'Заголовок';

  @override
  String get description_label => 'Описание';

  @override
  String get stop => 'Стоп';

  @override
  String get voice => 'Голос';
}
