import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:task_manager/main.i18n.dart';
import 'package:task_manager/model/app_state.dart';

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
    return Column(children: <Widget>[
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
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Current language:".i18n),
            StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Text(state.preferredLocale.toString());
                })
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text("Portuguese".i18n),
              onPressed: () => changeLanguage(context, Locale('pt', 'BR')),
            ),
            RaisedButton(
              child: Text("English".i18n),
              onPressed: () => changeLanguage(context, Locale('en', 'US')),
            ),
          ],
        )
      ],
    );
  }

  changeLanguage(BuildContext context, Locale locale) {
    print(locale.languageCode);
    I18n.of(context).locale = locale;
//    StoreProvider.of<AppState>(context)
//        .dispatch(ChangeLocaleAction(Locale(language)));
  }

  Widget numberOfTasksOption() {
    return Text('ttt');
  }

  Widget colorOptions() {
    return Text('ttt');
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
