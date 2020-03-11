import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/loading_reducer.dart';
import 'package:task_manager/redux/task_reducer.dart';
import 'package:task_manager/redux/task_schema_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      isLoading: loadingReducer(state.isLoading, action),
      monthlyTasks: taskReducer(state.monthlyTasks, action),
      selectedDays: [], //TODO IMPLEMENTS SELECTED DAYS REDUCER
      taskSchemas: taskSchemaReducer(state.taskSchemas, action));
}
