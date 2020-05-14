import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:task_manager/Service/helpers/preferences_helper.dart';
import 'package:task_manager/model/user_preferences.dart';

/// Service to isolate the actions for the User
class UserPreferencesService {
  static const String addTaskModal = 'addTaskModal';
  static const String countSize = 'countSize';
  static const String language = 'language';
  static const String country = 'country';

  static const String r = 'r';
  static const String g = 'g';
  static const String b = 'b';
  static const String o = 'o';

  static UserPreferencesService _instance;

  final log = Logger('UserPreferencesService');

  UserPreferencesService._();

  static UserPreferencesService get instance {
    return _instance ??= UserPreferencesService._();
  }

  Future<UserPreferences> loadUserPreferences() async {
    UserPreferences preferences = UserPreferences(
        addTaskModal: await _getAddTaskModal(),
        countColor: await _getCountColor(),
        countSize: await _getCountSize(),
        language: await _getLanguage());
    log.info('Preferences Loaded: ${preferences.toString()}');
    return preferences;
  }

  void saveUserPreferences(UserPreferences userPreferences) {
    _saveAddTaskModal(userPreferences.addTaskModal);
    _saveCountColor(userPreferences.countColor);
    _saveCountSize(userPreferences.countSize);
    _saveLanguage(userPreferences.language);
  }

  Future<int> _getCountSize() async {
    return await PreferencesHelper.getInt(countSize);
  }

  Future<Color> _getCountColor() async {
    return Color.fromRGBO(
        await PreferencesHelper.getInt(r),
        await PreferencesHelper.getInt(g),
        await PreferencesHelper.getInt(b),
        await PreferencesHelper.getDouble(o));
  }

  Future<Locale> _getLanguage() async {
    return Locale(await PreferencesHelper.getString(language),
        await PreferencesHelper.getString(country));
  }

  Future<bool> _getAddTaskModal() async {
    return await PreferencesHelper.getBool(addTaskModal);
  }

  Future<void> _saveCountSize(int countSizeValue) async {
    log.info('saving countSizeValue: $countSizeValue');
    return await PreferencesHelper.setInt(countSize, countSizeValue);
  }

  Future<void> _saveCountColor(Color color) async {
    log.info(
        'saving color: $color (${color.red},${color.green},${color.blue},${color.opacity})');
    await PreferencesHelper.setInt(r, color.red);
    await PreferencesHelper.setInt(g, color.green);
    await PreferencesHelper.setInt(b, color.blue);
    await PreferencesHelper.setDouble(o, color.opacity);
    return;
  }

  Future<void> _saveLanguage(Locale locale) async {
    log.info('saving locale: $locale');
    await PreferencesHelper.setString(language, locale.languageCode);
    await PreferencesHelper.setString(country, locale.countryCode);
    return;
  }

  Future<void> _saveAddTaskModal(bool addTaskModalValue) async {
    log.info('saving addTaskModalValue: $addTaskModalValue');
    return await PreferencesHelper.setBool(addTaskModal, addTaskModalValue);
  }
}
