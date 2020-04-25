import 'dart:async';
import 'dart:core';

import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';

abstract class TaskRepository {
  Future<Task> addTask(Task task);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(String id);

  Stream<List<Task>> getTasks(String userId);

  Future<void> processTasksFromSchema(TaskSchema allSchemas);
}
