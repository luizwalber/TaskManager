import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager/Service/task_service.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task_schema.dart';

/// Task to update monthly tasks in State based on a list of tasks
class LoadTaskSchemaAction extends ReduxAction<AppState> {
  final List<TaskSchema> taskSchemas;

  LoadTaskSchemaAction({@required this.taskSchemas})
      : assert(taskSchemas != null);

  @override
  AppState reduce() {
    TaskService.instance.processTasksFromSchemaList(taskSchemas);
    return state.copyWith(
      taskSchemas: taskSchemas,
    );
  }
}
