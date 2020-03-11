import 'package:flutter/foundation.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';

@immutable
class AppState {
  final bool isLoading;
  final Map<String, List<Task>> monthlyTasks;
  final List<bool> selectedDays;
  final List<TaskSchema> taskSchemas;

  AppState(
      {this.isLoading = false,
      @required this.monthlyTasks,
      @required this.selectedDays,
      @required this.taskSchemas});

  factory AppState.initial() {
    return AppState(
      isLoading: true,
      monthlyTasks: {},
      selectedDays: [false, false, false, false, false, false, false],
      taskSchemas: [],
    );
  }

  AppState copyWith({
    bool isLoading,
    final Map<String, List<Task>> monthlyTasks,
    List<bool> selectedDays,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      monthlyTasks: monthlyTasks ?? this.monthlyTasks,
      selectedDays: selectedDays ?? this.selectedDays,
      taskSchemas: taskSchemas ?? this.taskSchemas,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^ monthlyTasks.hashCode ^ selectedDays.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          monthlyTasks == other.monthlyTasks &&
          selectedDays == other.selectedDays &&
          taskSchemas == other.taskSchemas;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, monthlyTasks: $monthlyTasks, selectedDays: $selectedDays, taskSchemas: $taskSchemas}';
  }
}
