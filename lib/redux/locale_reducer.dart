import 'dart:ui';

import 'package:redux/redux.dart';
import 'package:task_manager/redux/actions/actions.dart';

final localeReducer = combineReducers<Locale>([
  TypedReducer<Locale, LoadLocaleAction>(_updatePreferedLocale),
]);

Locale _updatePreferedLocale(Locale user, LoadLocaleAction action) {
  return action.locale;
}
