import 'package:collection/collection.dart';
import 'package:redux/redux.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/utils/date_utils.dart';

final taskReducer = combineReducers<Map<String, List<Task>>>([
  TypedReducer<Map<String, List<Task>>, LoadTasksAction>(_updateMonthlyTaks),
  TypedReducer<Map<String, List<Task>>, AddTaskInState>(_addTaskInState),
//  TypedReducer<Map<String, List<Task>>, DeleteTaskAction>(_deleteTask),
]);

Map<String, List<Task>> _updateMonthlyTaks(
    Map<String, List<Task>> monthlyTasks, LoadTasksAction action) {
  return groupBy(action.tasks, (task) => dateDayHash(task.day));
}

Map<String, List<Task>> _addTaskInState(
    Map<String, List<Task>> monthlyTasks, AddTaskInState action) {
  String dayHash = dateDayHash(action.task.day);

  if (!monthlyTasks[dayHash].contains(action.task))
    monthlyTasks[dayHash].add(action.task);

  return monthlyTasks;
}
