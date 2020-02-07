import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      monthlyTasks: monthlyTasksReducer(state.monthlyTasks, action));
}

Map<String, List<Task>> monthlyTasksReducer(
    Map<String, List<Task>> monthlyTasks, dynamic action) {
  if (action is AddTaskAction)
    return Map.from(monthlyTasks)
      ..clear()
      ..addAll(action.monthlyTasks);
  if (action is DeleteTaskAction)
    return Map.from(monthlyTasks)
      ..clear()
      ..addAll(action.monthlyTasks);
  if (action is GetMonthlyTasks)
    return Map.from(monthlyTasks)
      ..clear()
      ..addAll(action.monthlyTasks);
  return monthlyTasks;
}
