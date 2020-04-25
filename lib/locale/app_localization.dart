import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/l10n/messages_all.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  /// TODO there's no better way to do this????
  /// https://flutter.dev/docs/development/accessibility-and-localization/internationalization
  // list of locales

  String get taskManagerTitle {
    return Intl.message(
      'Task Manager',
      name: 'taskManagerTitle',
    );
  }

  String get taskDialog {
    return Intl.message(
      'Task Dialog',
      name: 'taskDialog',
    );
  }

  String get taskTitlePlaceholder {
    return Intl.message(
      'What is the title?',
      name: 'taskTitlePlaceholder',
    );
  }

  String get taskTitleLabel {
    return Intl.message(
      'Title *',
      name: 'taskTitleLabel',
    );
  }

  String get repeat {
    return Intl.message(
      'Repeat',
      name: 'repeat',
    );
  }

  String get frequency {
    return Intl.message(
      'Frequency',
      name: 'frequency',
    );
  }

  String get useLocation {
    return Intl.message(
      'Use Location',
      name: 'useLocation',
    );
  }

  String get taskDescriptionPlaceholder {
    return Intl.message(
      'What is the task description',
      name: 'taskDescriptionPlaceholder',
    );
  }

  String get taskDescriptionLabel {
    return Intl.message(
      'Description',
      name: 'taskDescriptionLabel',
    );
  }

  String get submitTask {
    return Intl.message(
      'Submit Task',
      name: 'submitTask',
    );
  }

  String get titleEmpty {
    return Intl.message(
      'Title must not be empty',
      name: 'titleEmpty',
    );
  }

  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
    );
  }

  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
    );
  }

  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
    );
  }

  String get deleteSchemaTitle {
    return Intl.message(
      'Delete Task',
      name: 'deleteSchemaTitle',
    );
  }

  String get deleteSchemaDescription {
    return Intl.message(
      'Are you sure you want to delete the task ',
      name: 'deleteSchemaDescription',
    );
  }

  String get setLocation {
    return Intl.message(
      'Set Location',
      name: 'setLocation',
    );
  }

  String get language {
    return Intl.message(
      'Language',
      name: 'language',
    );
  }

  String get currentLanguage {
    return Intl.message(
      'Current language: ',
      name: 'currentLanguage',
    );
  }

  String get portuguese {
    return Intl.message(
      'Portuguese',
      name: 'portuguese',
    );
  }

  String get english {
    return Intl.message(
      'English',
      name: 'english',
    );
  }

  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
    );
  }

  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
    );
  }

  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
    );
  }

  String get custom {
    return Intl.message(
      'Custom',
      name: 'custom',
    );
  }

  String get once {
    return Intl.message(
      'Once',
      name: 'once',
    );
  }

  String get annually {
    return Intl.message(
      'Annually',
      name: 'annually',
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['en', 'pt'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
