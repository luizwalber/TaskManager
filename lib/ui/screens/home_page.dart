import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/main.i18n.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/actions/init_app_action.dart';
import 'package:task_manager/redux/view_model/task_list_view_model.dart';
import 'package:task_manager/ui/widgets/calendar.dart';
import 'package:task_manager/ui/widgets/task_list.dart';
import 'package:task_manager/utils/date_utils.dart';

// TODO show day in the middle of the divider between the calendar and the tasks
// TODO when the month has 6 weeks the screen breaks (out of bound)
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    store.dispatch(InitAppAction(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Calendar(),
          Divider(height: 30, thickness: 3, color: Colors.black12),
          _taskList(context)
        ],
      ),
    );
  }

  Widget _taskList(BuildContext context) {
    return Expanded(
        child: StoreConnector<AppState, TaskListViewModel>(
      model: TaskListViewModel(),
      builder: (context, vm) {
        return TaskList(
            selectedTasks: vm.monthlyTasks != null
                ? vm.monthlyTasks[dateDayHash(vm.selectedDay)]
                : '',
            selectedDay: vm.selectedDay);
      },
    ));
  }

  AppBar _appBar() {
    return AppBar(
        title: new Center(
            child: new Text("Task Manager".i18n, textAlign: TextAlign.center)),
        actions: <Widget>[_popupMenu()]);
  }

  PopupMenuButton<String> _popupMenu() {
    return PopupMenuButton<String>(
      onSelected: choiceAction,
      itemBuilder: (BuildContext context) {
        return [
          "Settings".i18n,
        ].map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  void choiceAction(String choice) {
    if (choice == "Settings".i18n) {
      Navigator.pushNamed(context, '/settings');
    }
  }
}
