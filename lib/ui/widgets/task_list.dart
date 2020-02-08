import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/redux/thunks.dart';
import 'package:task_manager/ui/screens/dialogs/add_task_dialog.dart';

/// bugs - add tasks with no task (HUGE)
class TaskList extends StatefulWidget {
  List selectedTasks;
  DateTime selectedDay;

  TaskList({Key key, this.selectedTasks, this.selectedDay}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  int selectedTask;

  @override
  void initState() {
    selectedTask = -1;
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    if (widget.selectedTasks == null)
      return _defaultAddTask(context, widget.selectedDay);

    List tasks =
        widget.selectedTasks.map((task) => _taskCards(task, context)).toList();
    tasks.add(_defaultAddTask(context, widget.selectedDay));

    return ListView(children: tasks);
  }

  Widget _taskCards(Task task, context) {
    return Stack(children: <Widget>[
      new Material(
        child: new InkWell(
            onTap: () => _onPressedTask(task),
            onLongPress: () =>
                addTaskDialog(context, task.createdForDay, task: task),
            child: AnimatedContainer(
                width: MediaQuery.of(context).size.width,
                height: selectedTask == task.id ? 160 : 80,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: buildTaskInfo(task))),
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

  Padding buildTaskInfo(Task task) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(task.title, textAlign: TextAlign.center));
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

  _onPressedTask(Task task) {
    print('New selected task id: ${task.id} title: ${task.title}');
    setState(() {
      if (selectedTask == task.id)
        selectedTask = -1;
      else
        selectedTask = task.id;
    });
  }
}
