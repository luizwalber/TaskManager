import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/thunks.dart';
import 'package:task_manager/ui/screens/dialogs/add_task_dialog.dart';

/// bugs - add tasks with no task (HUGE)

Widget buildTaskList(
    BuildContext context, List selectedTasks, DateTime selectedDay) {
  if (selectedTasks == null) return _defaultAddTask(context, selectedDay);

  List tasks = selectedTasks.map((task) => _taskCards(task, context)).toList();
  tasks.add(_defaultAddTask(context, selectedDay));

  return ListView(children: tasks);
}

Widget _taskCards(task, context) {
  return Stack(children: <Widget>[
    Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(task.title.toString()), onTap: _onPressedTask(task)),
      ),
    ),
    Positioned(
      top: 0,
      right: 1,
      child: Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            padding: EdgeInsets.all(0.0),
            color: Colors.red,
            child: Text(''),
            onPressed: () => _deleteTask(context, task)),
      ),
    )
  ]);
}

void _deleteTask(context, task) {
  StoreProvider.of<AppState>(context).dispatch(deleteTask(task));
}

Widget _defaultAddTask(BuildContext context, DateTime selectedDay) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(width: 0.8),
      borderRadius: BorderRadius.circular(12.0),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: ListTile(
      title: Center(child: Icon(Icons.add)),
      onTap: () => addTaskDialog(context, selectedDay),
    ),
  );
}

_onPressedTask(task) {
  print('$task tapped!');
}
