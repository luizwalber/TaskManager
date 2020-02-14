import 'package:flutter/foundation.dart';
import 'package:task_manager/model/task.dart';

@immutable
class AppState {
  final Map<String, List<Task>> monthlyTasks;
  final List<bool> selectedDays;

  AppState({
    @required this.monthlyTasks,
    @required this.selectedDays,
  });

  factory AppState.initial() {
    // TODO how to load tasks here?
    return AppState(
      monthlyTasks: {},
      selectedDays: [false, false, false, false, false, false, false],
    );
  }
}
