

import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/main.i18n.dart';
import 'package:task_manager/model/user_preferences.dart';
import 'package:task_manager/redux/actions/save_user_preferences_action.dart';

class SettingsDrawer extends StatelessWidget {
  final UserPreferences userPreferences;

  SettingsDrawer(this.userPreferences);

  @override
  Widget build(BuildContext context) {
    return LocaleOptions(context);
  }

  
  Widget LocaleOptions(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            body: Column(mainAxisSize: MainAxisSize.max,
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Task Manager'.i18n),
                    Text("Current language:".i18n + "${I18n.localeStr}".i18n),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Portuguese".i18n),
                          onPressed: () => changeLanguage(
                            context,
                            'pt',
                            'BR',
                            userPreferences,
                          ),
                        ),
                        RaisedButton(
                          child: Text("English".i18n),
                          onPressed: () => changeLanguage(
                            context,
                            'en',
                            'US',
                            userPreferences,
                          ),
                        ),
                      ],
                    )
                  ]),
      ),
    );
  }


  
  void changeLanguage(BuildContext context, String languageCode,
      String countryCode, UserPreferences userPreferences) {
    Locale locale = Locale(languageCode, countryCode);
    I18n.of(context).locale = locale;
    //initializeDateFormatting('${languageCode}_${countryCode}', null);

    store.dispatch(SaveUserPreferencesAction(
      userPreferences: userPreferences.copyWith(language: locale),
    ));
  }
}
