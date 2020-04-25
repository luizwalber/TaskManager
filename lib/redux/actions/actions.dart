import 'dart:ui';

import 'package:task_manager/model/User.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';

class InitAppAction {
  @override
  String toString() {
    return 'InitAppAction{}';
  }
}

class StartTaskListener {
  StartTaskListener();

  @override
  String toString() {
    return 'StartTaskListener {}';
  }
}

class StartSchemaListener {
  StartSchemaListener();

  @override
  String toString() {
    return 'StartSchemaListener {}';
  }
}

class AddTaskAction {
  final Task task;

  AddTaskAction(this.task);

  @override
  String toString() {
    return 'AddTaskAction{task: $task}';
  }
}

class AddTaskInState {
  final Task task;

  AddTaskInState(this.task);

  @override
  String toString() {
    return 'AddTaskInState{task: $task}';
  }
}

class UpdateTaskAction {
  final Task task;

  UpdateTaskAction(this.task);

  @override
  String toString() {
    return 'UpdateTaskAction{task: $task}';
  }
}

class DeleteTaskAction {
  final String schemaId;

  DeleteTaskAction(this.schemaId);

  @override
  String toString() {
    return 'DeleteTaskAction{schemaId: $schemaId}';
  }
}

class LoadTasksAction {
  final List<Task> tasks;

  LoadTasksAction(this.tasks);

  @override
  String toString() {
    return 'LoadTasksAction{tasks: $tasks}';
  }
}

class LoadTaskSchemaAction {
  final List<TaskSchema> taskSchema;

  LoadTaskSchemaAction(this.taskSchema);

  @override
  String toString() {
    return 'LoadTaskSchemaAction{taskSchema: $taskSchema}';
  }
}

class AddTaskSchemaAction {
  final TaskSchema taskSchema;

  AddTaskSchemaAction(this.taskSchema);

  @override
  String toString() {
    return 'AddTaskSchemaAction{taskSchema: $taskSchema}';
  }
}

class UpdateTaskSchemaAction {
  final TaskSchema taskSchema;

  UpdateTaskSchemaAction(this.taskSchema);

  @override
  String toString() {
    return 'UpdateTaskSchemaAction{taskSchema: $taskSchema}';
  }
}

class ChangeMonthAction {
  final int year;
  final int month;

  ChangeMonthAction(this.year, this.month);

  @override
  String toString() {
    return 'ChangeMonthAction{ Year: $year Month: $month}';
  }
}

class DeleteTaskSchemaAction {
  final String id;

  DeleteTaskSchemaAction(this.id);

  @override
  String toString() {
    return 'DeleteTaskSchemaAction {id: $id}';
  }
}

class LoadUserAction {
  final User user;

  LoadUserAction(this.user);

  @override
  String toString() {
    return 'LoadUserAction {user: $user}';
  }
}

class GetLocaleAction {
  final Locale locale;

  GetLocaleAction(this.locale);

  @override
  String toString() {
    return 'LoadLocaleAction {locale: $locale}';
  }
}

class LoadLocaleAction {
  final Locale locale;

  LoadLocaleAction(this.locale);

  @override
  String toString() {
    return 'LoadLocaleAction {locale: $locale}';
  }
}

class ChangeLocaleAction {
  final Locale locale;

  ChangeLocaleAction(this.locale);

  @override
  String toString() {
    return 'ChangeLocaleAction {locale: $locale}';
  }
}
