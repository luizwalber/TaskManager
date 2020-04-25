import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/repository/locale_repository.dart';

void Function(
  Store<AppState> store,
  GetLocaleAction action,
  NextDispatcher next,
) fetchLocale(
  LocaleRepository localeRepository,
) {
  return (store, action, next) async {
    next(action);
    localeRepository.fetchUserLocale().then((value) {
      Locale locale = Locale(value);
      store.dispatch(LoadLocaleAction(locale));
    });
  };
}

void Function(
  Store<AppState> store,
  ChangeLocaleAction action,
  NextDispatcher next,
) changeLocale(
  LocaleRepository localeRepository,
) {
  return (store, action, next) async {
    next(action);
    localeRepository
        .changeLocale(action.locale.languageCode)
        .then((value) => store.dispatch(LoadLocaleAction(action.locale)));
    store.dispatch(GetLocaleAction);
  };
}
