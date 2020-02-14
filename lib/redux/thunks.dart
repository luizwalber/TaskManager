import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:task_manager/database/task_database_helper.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/redux/actions.dart';

/// Add a task
ThunkAction<AppState> addTask(Task task) {
  return (Store<AppState> store) async {
    TaskDatabaseHelper().insert(task);
    Map<String, List<Task>> updatedMonthlyTasks =
        await TaskDatabaseHelper().getTasksNearMonthTasks(task.month);

    store.dispatch(AddTaskAction(updatedMonthlyTasks));
  };
}

/// Delete a task
ThunkAction<AppState> deleteTask(Task task) {
  return (Store<AppState> store) async {
    TaskDatabaseHelper().delete(task.id);
    Map<String, List<Task>> updatedMonthlyTasks =
        await TaskDatabaseHelper().getTasksNearMonthTasks(task.month);
    store.dispatch(DeleteTaskAction(updatedMonthlyTasks));
  };
}

// -----------------------------------------------------------------------
/// TODO get the tasks from the current month and the month before and after
ThunkAction<AppState> getMonthlyTasks(month) {
  return (Store<AppState> store) async {
    Map<String, List<Task>> monthlyTasks =
        await TaskDatabaseHelper().getTasksNearMonthTasks(month);

    store.dispatch(GetMonthlyTasks(monthlyTasks));
  };
}

/// Update a Task
ThunkAction<AppState> updateTask(Task task) {
  return (Store<AppState> store) async {
    await TaskDatabaseHelper().updateStatus(task.id, task.status);

    Map<String, List<Task>> updatedMonthlyTasks =
        await TaskDatabaseHelper().getTasksNearMonthTasks(task.month);
    store.dispatch(AddTaskAction(updatedMonthlyTasks));
  };
}
