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
import 'package:task_manager/repository/task_repository.dart';
import 'package:task_manager/ui/screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(TaskManager());
}

class TaskManager extends StatelessWidget {
  final Store<AppState> store;

  TaskManager({
    Key key,
    TaskRepository taskRepository,
    UserRepository userRepository,
  })  : store = Store<AppState>(
          appReducer,
          initialState: AppState.loading(),
          middleware: createStoreTodosMiddleware(
            taskRepository ??
                FirestoreReactiveTodosRepository(Firestore.instance),
            userRepository ?? FirebaseUserRepository(FirebaseAuth.instance),
          ),
        ),
        super(key: key) {
    store.dispatch(InitAppAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        onGenerateTitle: (context) =>
            FirestoreReduxLocalizations.of(context).appTitle,
        theme: ArchSampleTheme.theme,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          FirestoreReduxLocalizationsDelegate(),
        ],
        routes: {
          ArchSampleRoutes.home: (context) => HomeScreen(),
          ArchSampleRoutes.addTodo: (context) => AddTodo(),
        },
      ),
    );
  }
}

//void main() {
//  final store = Store<AppState>(appReducer,
//      initialState: AppState.initial(),
//      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
//  initializeDateFormatting().then((_) => runApp(MyApp(store: store)));
//}

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
          '/1': (BuildContext context) => Test()
        },
      ),
    );
  }
}

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with TickerProviderStateMixin {
  double _heigth = 100;
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          InkWell(
              onTap: () => _onPressedTask(),
              child: AnimatedContainer(
                  width: MediaQuery.of(context).size.width,
//            height: _heigth,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: buildCardInfo())),
          Expanded(
            child: InkWell(
                onTap: () => _onPressedTask(),
                child: AnimatedContainer(
                    width: MediaQuery.of(context).size.width,
//            height: _heigth,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: buildCardInfo())),
          ),
        ]),
      ),
    );
  }

  _onPressedTask() {
    setState(() {
      _heigth = _selected ? _heigth / 2 : _heigth * 2;
      _selected = !_selected;
    });
  }

  Column buildCardInfo() {
    return Column(
      children: <Widget>[
        Text("123"),
        Visibility(
            visible: _selected,
            child: Text(
                "4fdg sdfg sdf gsdfg sdfg sdfgsdfg sdf gsdf gsd fg dsfg sdfg sdfg sdfg sd fgsd fg dfg sdfg sdfg sd sd fgs dfgs fgs fg sdfg sdf sdf gsd fg sdfg sdfg sd fgs dfg sdfg sdfg sdfg sdfgsdf gs gs fgsdfgsdf566"))
      ],
    );
  }
}
