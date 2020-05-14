//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/ui/screens/home_page.dart';
import 'package:task_manager/ui/screens/settings.dart';

Store<AppState> store;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
//  initializeDateFormatting('pt_br', null).then((_) => runApp(TaskManager()));
  var state = AppState.initial();
  store = Store<AppState>(initialState: state);
  runApp(TaskManager());
}

class TaskManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: FlutterEasyLoading(
        child: MaterialApp(
          supportedLocales: [
            const Locale('pt', 'BR'),
            const Locale('en', 'US'),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) {
              return I18n(
                child: HomePage(),
              );
            },
            '/settings': (context) {
              return I18n(
                child: Settings(),
              );
            },
          },
        ),
      ),
    );
  }
}
