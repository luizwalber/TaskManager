import 'package:flutter/foundation.dart';
import 'package:task_manager/model/task.dart';

@immutable
class AppState {
  final Map<String, List<Task>> monthlyTasks;

  AppState({
    @required this.monthlyTasks,
  });

  factory AppState.initial() {
    final Map<String, List<Task>> tasks = {}; // TODO how to load tasks here?
    return AppState(monthlyTasks: tasks);
  }
}
