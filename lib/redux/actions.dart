import 'package:task_manager/model/task.dart';

class AddTaskAction {
  Map<String, List<Task>> _monthlyTasks;

  Map<String, List<Task>> get monthlyTasks => this._monthlyTasks;

  AddTaskAction(this._monthlyTasks);
}

class DeleteTaskAction {
  Map<String, List<Task>> _monthlyTasks;

  Map<String, List<Task>> get monthlyTasks => this._monthlyTasks;

  DeleteTaskAction(this._monthlyTasks);
}

class UpdateMonthlyTasks {
  Map<String, List<Task>> _monthlyTasks;

  Map<String, List<Task>> get monthlyTasks => this._monthlyTasks;

  UpdateMonthlyTasks(this._monthlyTasks);
}

class UpdateTask {
  Map<String, List<Task>> _monthlyTasks;

  Map<String, List<Task>> get monthlyTasks => this._monthlyTasks;

  UpdateTask(this._monthlyTasks);
}

class GetMonthlyTasks {
  Map<String, List<Task>> _monthlyTasks;

  Map<String, List<Task>> get monthlyTasks => this._monthlyTasks;

  GetMonthlyTasks(this._monthlyTasks);
}
