import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/user_preferences.dart';

/// Helper to hold part of the state info
class UserPreferencesViewModel extends BaseModel<AppState> {
  UserPreferencesViewModel();

  UserPreferences userPreferences;

  List<bool> selectedDays;

  UserPreferencesViewModel.build({
    @required this.userPreferences,
  }) : super(equals:[userPreferences]);

  @override
  UserPreferencesViewModel fromStore() => UserPreferencesViewModel.build(
        userPreferences: state.userPreferences,
      );
}
