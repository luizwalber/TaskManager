import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/ui/screens/dialogs/add_task_dialog.dart';
import 'package:task_manager/ui/screens/dialogs/simple_dialogs.dart';
import 'package:task_manager/utils/enums.dart';

/// TODO bugs - add tasks with no task (HUGE) // titles with more than 1 line in title will break the layout
/// TODO component?? tasks not selecting after multiple clicks

class TaskList extends StatefulWidget {
  final List<Task> selectedTasks;
  final DateTime selectedDay;

  TaskList({Key key, this.selectedTasks, this.selectedDay}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

// TODO não deve ter esse dailytaskstatus, pega da task mesmo
class _TaskListState extends State<TaskList> {
  String selectedTask;
  Map<String, TaskStatus> dailyTaskStatus = {};

  void initState() {
    selectedTask = null;
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    if (widget.selectedTasks == null)
      return ListView(
          children: <Widget>[_defaultAddTask(context, widget.selectedDay)]);
    widget.selectedTasks
        .sort((Task task1, Task task2) => task1.title.compareTo(task2.title));
    List<Widget> tasks = widget.selectedTasks
        .map((Task task) => _taskCards(task, context))
        .toList();

    tasks.add(_defaultAddTask(context, widget.selectedDay));

    return ListView(children: tasks);
  }

  Widget _taskCards(Task task, context) {
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Material(
          child: InkWell(
              onTap: () => _onPressedTask(task),
              onLongPress: () => addTaskDialog(context, task.day, task: task),
              child: AnimatedContainer(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: buildTaskInfo(task))),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.cancel,
                color: Colors.red,
                size: 30,
              ),
              onPressed: () => _deleteTask(context, task)),
        ),
      )
    ]);
  }

  Column buildTaskInfo(Task task) {
    return Column(
      children: <Widget>[
        _titleColumn(task),
        Visibility(
            visible: (selectedTask == task.id), child: _taskDetails(task))
      ],
    );
  }

  Widget _taskDetails(Task task) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: <Widget>[
          Text(task.description),
          Visibility(
            visible: task.useLocation,
            child: Center(
              child: RaisedButton.icon(
                color: Colors.lightBlue[100],
                icon: Icon(Icons.map),
                label: Text("Set Location"),
                onPressed: () => {},
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _titleColumn(Task task) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text('${task.title}', style: TextStyle(fontSize: 18))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 25,
              width: 25,
              child: FloatingActionButton(
                backgroundColor: _doneColor(task),
                elevation: 2,
                onPressed: () => _changeTaskStatus(TaskStatus.DONE, task),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 25,
              width: 25,
              child: FloatingActionButton(
                backgroundColor: _partiallyColor(task),
                elevation: 2,
                onPressed: () => _changeTaskStatus(TaskStatus.PARTIALLY, task),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 25,
              width: 25,
              child: FloatingActionButton(
                backgroundColor: _notDoneColor(task),
                elevation: 2,
                onPressed: () => _changeTaskStatus(TaskStatus.NOT_DONE, task),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteTask(BuildContext context, Task task) async {
    ConfirmAction confirmation = await confirmDialog(
      context,
      "Delete Task ${task.title}",
      "Are you sure want to delete task ${task.title}? this action can't be undone",
    );
    if (confirmation == ConfirmAction.ACCEPT) {
      StoreProvider.of<AppState>(context).dispatch(DeleteTaskAction(task.id));
    }
  }

  Widget _defaultAddTask(BuildContext context, DateTime selectedDay) {
    return Material(
      child: InkWell(
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Center(child: Icon(Icons.add)),
        ),
        onTap: () => addTaskDialog(context, selectedDay),
      ),
    );
  }

  _onPressedTask(Task task) {
    print('New selected task id: ${task.id} title: ${task.title}');
    setState(() {
      if (selectedTask == task.id)
        selectedTask = null;
      else
        selectedTask = task.id;
    });
  }

  Color _doneColor(Task task) {
    return dailyTaskStatus[task.id] == TaskStatus.DONE ||
            dailyTaskStatus == null
        ? Colors.green
        : Colors.grey[200];
  }

  Color _partiallyColor(Task task) {
    return dailyTaskStatus[task.id] == TaskStatus.PARTIALLY ||
            dailyTaskStatus == null
        ? Colors.orange
        : Colors.grey[400];
  }

  Color _notDoneColor(Task task) {
    return dailyTaskStatus[task.id] == TaskStatus.NOT_DONE ||
            dailyTaskStatus == null
        ? Colors.redAccent
        : Colors.grey[600];
  }

  void _changeTaskStatus(TaskStatus taskStatus, Task task) {
    setState(() {
      dailyTaskStatus.remove(task.id);
      dailyTaskStatus.putIfAbsent(task.id, () => taskStatus);
    });
    task.status = taskStatus;

    StoreProvider.of<AppState>(context).dispatch(UpdateTaskAction(task));
  }
}
