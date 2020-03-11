import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';

class InitAppAction {
  @override
  String toString() {
    return 'InitAppAction{}';
  }
}

class GetTasksNearMonth {
  int month;
  int year;

  GetTasksNearMonth(this.month, this.year);

  @override
  String toString() {
    return 'StartMonthListener {month: $month, year: $year';
  }
}

class StartSchemaListener {
  StartSchemaListener();

  @override
  String toString() {
    return 'StartSchemaListener {';
  }
}

class AddTaskAction {
  final Task task;

  AddTaskAction(this.task);

  @override
  String toString() {
    return 'AddTaskAction{todo: $task}';
  }
}

class AddTaskInState {
  final Task task;

  AddTaskInState(this.task);

  @override
  String toString() {
    return 'AddTaskAction{todo: $task}';
  }
}

class UpdateTaskAction {
  final Task task;

  UpdateTaskAction(this.task);

  @override
  String toString() {
    return 'UpdateTaskAction{todo: $task}';
  }
}

class DeleteTaskAction {
  final String id;

  DeleteTaskAction(this.id);

  @override
  String toString() {
    return 'DeleteTaskAction{todos: $id}';
  }
}

class LoadTasksAction {
  final List<Task> tasks;

  LoadTasksAction(this.tasks);

  @override
  String toString() {
    return 'TransformTaskAction{todos: $tasks}';
  }
}

class LoadTaskSchemaAction {
  final List<TaskSchema> taskSchema;

  LoadTaskSchemaAction(this.taskSchema);

  @override
  String toString() {
    return 'TransformTaskAction{todos: $taskSchema}';
  }
}

class AddTaskSchemaAction {
  final TaskSchema taskSchema;

  AddTaskSchemaAction(this.taskSchema);

  @override
  String toString() {
    return 'UpdateTaskSchemaAction{todo: $taskSchema}';
  }
}

class UpdateTaskSchemaAction {
  final TaskSchema taskSchema;

  UpdateTaskSchemaAction(this.taskSchema);

  @override
  String toString() {
    return 'UpdateTaskSchemaAction{todo: $taskSchema}';
  }
}

class DeleteTaskSchemaAction {
  final String id;

  DeleteTaskSchemaAction(this.id);

  @override
  String toString() {
    return 'DeleteTaskSchemaAction{todos: $id}';
  }
}

class StartLoading {
  @override
  String toString() {
    return 'StartLoading{}';
  }
}

class StopLoading {
  @override
  String toString() {
    return 'StopLoading{}';
  }
}
