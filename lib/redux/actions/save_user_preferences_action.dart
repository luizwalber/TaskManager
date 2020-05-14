import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/Service/user_pref_service.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/user_preferences.dart';

/// Task to update monthly tasks in State based on a list of tasks
class SaveUserPreferencesAction extends ReduxAction<AppState> {
  final UserPreferences userPreferences;

  SaveUserPreferencesAction({@required this.userPreferences})
      : assert(userPreferences != null);

  @override
  Future<AppState> reduce() async {
    await UserPreferencesService.instance.saveUserPreferences(userPreferences);
    return state.copyWith(userPreferences: userPreferences);
  }
}
