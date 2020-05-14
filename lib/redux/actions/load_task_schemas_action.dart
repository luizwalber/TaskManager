import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_manager/Service/task_service.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task_schema.dart';

/// Task to update monthly tasks in State based on a list of tasks
class LoadTaskSchemaAction extends ReduxAction<AppState> {
  final List<TaskSchema> taskSchemas;

  LoadTaskSchemaAction({@required this.taskSchemas})
      : assert(taskSchemas != null);

  void before() {
    EasyLoading.show();
  }

  void after() {
    EasyLoading.dismiss();
  }

  @override
  Future<AppState> reduce() async {
    return state.copyWith(
      taskSchemas:
          await TaskService.instance.processTasksFromSchemaList(taskSchemas),
    );
  }
}
