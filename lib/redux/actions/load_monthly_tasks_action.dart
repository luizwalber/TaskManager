import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager/Service/task_service.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';

/// Task to update monthly tasks in State based on a list of tasks
class LoadMonthlyTasksAction extends ReduxAction<AppState> {
  final List<Task> tasks;

  LoadMonthlyTasksAction({@required this.tasks}) : assert(tasks != null);

  @override
  AppState reduce() {
    return state.copyWith(
      monthlyTasks: TaskService.instance.groupTasksByMonth(tasks),
    );
  }
}
