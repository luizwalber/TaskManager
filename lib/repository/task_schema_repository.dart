import 'dart:async';
import 'dart:core';

import 'package:task_manager/model/task_schema.dart';

abstract class TaskSchemaRepository {
  Future<TaskSchema> addTaskSchema(TaskSchema taskSchema);

  Future<void> updateTaskSchema(TaskSchema taskSchema);

  Future<void> deleteTaskSchema(String id);

  Stream<List<TaskSchema>> getAllTaskSchema();
}
