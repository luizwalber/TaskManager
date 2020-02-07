//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/reducers.dart';
import 'package:task_manager/redux/thunks.dart';
import 'package:task_manager/ui/screens/home_page.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  initializeDateFormatting().then((_) => runApp(MyApp(store: store)));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final String _title = 'Task Manager';

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: _title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (BuildContext context) => HomePage(
              title: _title,
              onInit: () {
                StoreProvider.of<AppState>(context)
                    .dispatch(getMonthlyTasks(DateTime.now().month));
              }),
        },
      ),
    );
  }
}
