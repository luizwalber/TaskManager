import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';

/// Helper to holds part of the state info
class TaskListViewModel extends BaseModel<AppState> {
  Map<String, List<Task>> monthlyTasks;
  DateTime selectedDay;

  TaskListViewModel();

  TaskListViewModel.build({
    @required this.monthlyTasks,
    @required this.selectedDay,
  }) : super(equals: [monthlyTasks, selectedDay]);

  @override
  TaskListViewModel fromStore() {
    return TaskListViewModel.build(
      monthlyTasks: state.monthlyTasks,
      selectedDay: state.selectedDay,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is TaskListViewModel &&
          runtimeType == other.runtimeType &&
          monthlyTasks == other.monthlyTasks &&
          selectedDay == other.selectedDay;

  @override
  int get hashCode =>
      super.hashCode ^ monthlyTasks.hashCode ^ selectedDay.hashCode;
}
