import 'package:collection/collection.dart';
import 'package:redux/redux.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/utils/date_utils.dart';

final taskReducer = combineReducers<Map<String, List<Task>>>([
  TypedReducer<Map<String, List<Task>>, LoadTasksAction>(_updateMonthlyTasks),
]);

Map<String, List<Task>> _updateMonthlyTasks(
    Map<String, List<Task>> monthlyTasks, LoadTasksAction action) {
  return groupBy(action.tasks, (task) => dateDayHash(task.day));
}
