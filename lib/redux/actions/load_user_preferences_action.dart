import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:task_manager/Service/user_pref_service.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/user_preferences.dart';

/// Task to update monthly tasks in State based on a list of tasks
class LoadUserPreferencesAction extends ReduxAction<AppState> {
  final BuildContext context;

  LoadUserPreferencesAction({@required this.context}) : assert(context != null);

  @override
  Future<AppState> reduce() async {
    UserPreferences userPreferences =
        await UserPreferencesService.instance.loadUserPreferences();

    if (userPreferences.language != null) {
      I18n.of(context).locale = userPreferences.language;
    }
    return state.copyWith(
      userPreferences: userPreferences,
    );
  }
}
