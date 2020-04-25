import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/locale_reducer.dart';
import 'package:task_manager/redux/task_reducer.dart';
import 'package:task_manager/redux/task_schema_reducer.dart';
import 'package:task_manager/redux/user_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    monthlyTasks: taskReducer(state.monthlyTasks, action),
    selectedDays: [],
    //TODO IMPLEMENTS SELECTED DAYS REDUCER
    taskSchemas: taskSchemaReducer(state.taskSchemas, action),
    loggedUser: userReducer(state.loggedUser, action),
    preferredLocale: localeReducer(state.preferredLocale, action),
  );
}
