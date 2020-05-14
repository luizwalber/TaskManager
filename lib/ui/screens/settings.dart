import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/main.i18n.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/user_preferences.dart';
import 'package:task_manager/redux/actions/save_user_preferences_action.dart';
import 'package:task_manager/redux/view_model/user_preferences_view_model.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _options(context),
    );
  }

  Widget _options(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      LocaleOptions(context),
      Divider(
        height: 50,
        thickness: 5,
      ),
      numberOfTasksOption(),
      colorOptions(),
    ]);
  }

  Widget LocaleOptions(BuildContext context) {
    return StoreConnector<AppState, UserPreferencesViewModel>(
        model: UserPreferencesViewModel(),
        builder: (context, vm) {
          return Column(mainAxisSize: MainAxisSize.max,
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Current language:".i18n + "${I18n.localeStr}".i18n),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Portuguese".i18n),
                      onPressed: () => changeLanguage(
                        context,
                        Locale('pt', 'BR'),
                        vm.userPreferences,
                      ),
                    ),
                    RaisedButton(
                      child: Text("English".i18n),
                      onPressed: () => changeLanguage(
                        context,
                        Locale('en', 'US'),
                        vm.userPreferences,
                      ),
                    ),
                  ],
                )
              ]);
        });
  }

  void changeLanguage(
      BuildContext context, Locale locale, UserPreferences userPreferences) {
    print(locale.languageCode);
    I18n.of(context).locale = locale;
    store.dispatch(SaveUserPreferencesAction(
      userPreferences: userPreferences.copyWith(language: locale),
    ));
  }

  Widget numberOfTasksOption() {
    return Text('ttt');
  }

  Widget colorOptions() {
    return Text('asdfasdf');
  }

  AppBar _appBar() {
    return AppBar(
        title: new Center(
            child: new Text("Settings".i18n, textAlign: TextAlign.center)));
  }
}

// idioma
// tamanho
// cor
// modo exibição da criação de tarefa
//
//
//
//
//
//
