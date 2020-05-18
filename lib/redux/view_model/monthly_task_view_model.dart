import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';

/// Helper to holds part of the state info
class CalendarViewModel extends BaseModel<AppState> {
  Map<String, List<Task>> monthlyTasks;
  List<TaskSchema> taskSchemas;

  CalendarViewModel();

  CalendarViewModel.build({
    @required this.monthlyTasks,
    @required this.taskSchemas,
  }) : super(equals: [monthlyTasks, taskSchemas]);

  @override
  CalendarViewModel fromStore() {
    return CalendarViewModel.build(
      monthlyTasks: state.monthlyTasks,
      taskSchemas: state.taskSchemas,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is CalendarViewModel &&
          runtimeType == other.runtimeType &&
          monthlyTasks == other.monthlyTasks &&
          taskSchemas == other.taskSchemas;

  @override
  int get hashCode =>
      super.hashCode ^ monthlyTasks.hashCode ^ taskSchemas.hashCode;
}
