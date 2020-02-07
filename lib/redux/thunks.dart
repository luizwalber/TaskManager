import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:task_manager/database/task_database_helper.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/redux/actions.dart';
import 'package:task_manager/utils/date_utils.dart';

/// Add a task
ThunkAction<AppState> addTask(Task task) {
  return (Store<AppState> store) async {
    final Map<String, List<Task>> updatedMonthlyTasks =
        Map.from(store.state.monthlyTasks);
    final String dayHash = dateDayHash(task.createdForDay);
    final List<Task> updatedDailyTasks =
        List.from(updatedMonthlyTasks[dayHash] ?? [])..add(task);

    updatedMonthlyTasks[dayHash] = updatedDailyTasks;

    TaskDatabaseHelper().insert(task);

    store.dispatch(AddTaskAction(updatedMonthlyTasks));
  };
}

/// Delete a task
ThunkAction<AppState> deleteTask(Task task) {
  return (Store<AppState> store) async {
    final Map<String, List<Task>> updatedMonthlyTasks =
        Map.from(store.state.monthlyTasks);
    final String dayHash = dateDayHash(task.createdForDay);
    //TODO implementar logica para remover apenas essa ocorrencia ou as repetiçoes
    final List<Task> updatedDailyTasks =
        List.from(updatedMonthlyTasks[dayHash] ?? [])..remove(task);

    updatedMonthlyTasks[dayHash] = updatedDailyTasks;

    TaskDatabaseHelper().delete(task.id);
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

Map<String, List<Task>> oldInitializeTasks() {
  Map<String, List<Task>> _tasks;
  final _selectedDay = DateTime.now();
  _tasks = {
    dateDayHash(_selectedDay.subtract(Duration(days: 30))): [
      Task(title: 'Event A0'),
      Task(title: 'Event B0'),
      Task(title: 'Event C0')
    ],
    dateDayHash(_selectedDay.subtract(Duration(days: 27))): [
      Task(title: 'Event A1')
    ],
    dateDayHash(_selectedDay.subtract(Duration(days: 20))): [
      Task(title: 'Event A2'),
      Task(title: 'Event B2'),
      Task(title: 'Event C2'),
      Task(title: 'Event D2')
    ],
    dateDayHash(_selectedDay.subtract(Duration(days: 16))): [
      Task(title: 'Event A3'),
      Task(title: 'Event B3'),
    ],
    dateDayHash(_selectedDay.subtract(Duration(days: 10))): [
      Task(title: 'Event A4'),
      Task(title: 'Event B4'),
      Task(title: 'Event C4')
    ],
    dateDayHash(_selectedDay.subtract(Duration(days: 4))): [
      Task(title: 'Event A5'),
      Task(title: 'Event B5'),
      Task(title: 'Event C5')
    ],
    dateDayHash(_selectedDay.subtract(Duration(days: 2))): [
      Task(title: 'Event A611'),
      Task(title: 'Event B6')
    ],
    dateDayHash(_selectedDay): [
      Task(title: 'Event A7'),
      Task(title: 'Event B7'),
      Task(title: 'Event C7'),
      Task(title: 'Event D7')
    ],
    dateDayHash(_selectedDay.add(Duration(days: 1))): [
      Task(title: 'Event A8'),
      Task(title: 'Event B8'),
      Task(title: 'Event C8'),
      Task(title: 'Event D8')
    ],
    dateDayHash(_selectedDay.add(Duration(days: 7))): [
      Task(title: 'Event A10'),
      Task(title: 'Event B10'),
      Task(title: 'Event C10')
    ],
    dateDayHash(_selectedDay.add(Duration(days: 11))): [
      Task(title: 'Event A11'),
      Task(title: 'Event B11')
    ],
    dateDayHash(_selectedDay.add(Duration(days: 17))): [
      Task(title: 'Event A12'),
      Task(title: 'Event B12'),
      Task(title: 'Event C12'),
      Task(title: 'Event D12')
    ],
    dateDayHash(_selectedDay.add(Duration(days: 22))): [
      Task(title: 'Event A13'),
      Task(title: 'Event B13')
    ],
    dateDayHash(_selectedDay.add(Duration(days: 26))): [
      Task(title: 'Event A14'),
      Task(title: 'Event B14'),
      Task(title: 'Event C14')
    ],
  };
  return _tasks;
}
