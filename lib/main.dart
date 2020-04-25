//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:redux/redux.dart';
import 'package:task_manager/Service/locale_service.dart';
import 'package:task_manager/Service/task_schema_service.dart';
import 'package:task_manager/Service/task_service.dart';
import 'package:task_manager/Service/user_service.dart';
import 'package:task_manager/middleware/middleware.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/redux/reducer.dart';
import 'package:task_manager/repository/locale_repository.dart';
import 'package:task_manager/repository/task_repository.dart';
import 'package:task_manager/repository/task_schema_repository.dart';
import 'package:task_manager/repository/user_repository.dart';
import 'package:task_manager/ui/screens/home_page.dart';
import 'package:task_manager/ui/screens/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
//  initializeDateFormatting('pt_br', null).then((_) => runApp(TaskManager()));
  runApp(TaskManager());
}

class TaskManager extends StatelessWidget {
  final Store<AppState> store;

  TaskManager({
    Key key,
    TaskRepository taskRepository,
    TaskSchemaRepository taskSchemaRepository,
    UserRepository userRepository,
    LocaleRepository localeRepository,
  })  : store = Store<AppState>(appReducer,
            initialState: AppState.initial(),
            middleware: taskMiddleware(
              taskRepository ?? TaskService(Firestore.instance),
              taskSchemaRepository ?? TaskSchemaService(Firestore.instance),
              userRepository ?? UserService(FirebaseAuth.instance),
              localeRepository ?? LocaleService(),
            )),
        super(key: key) {
    store.dispatch(InitAppAction());
  }

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
                //initialLocale: Locale("en", "US"), //not defined = system locale
                child: HomePage(),
              );
            },
            '/settings': (context) {
              return I18n(
                child: Settings(),
                //initialLocale: Locale("pt", "BR"),
              );
            },
          },
        ),
      ),
    );
  }
}
