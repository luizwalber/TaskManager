import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:task_manager/model/User.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';

@immutable
class AppState {
  final Map<String, List<Task>> monthlyTasks;
  final List<bool> selectedDays;
  final List<TaskSchema> taskSchemas;
  final User loggedUser;
  final Locale preferredLocale;

  AppState({
    @required this.monthlyTasks,
    @required this.selectedDays,
    @required this.taskSchemas,
    @required this.loggedUser,
    @required this.preferredLocale,
  });

  factory AppState.initial() {
    return AppState(
      monthlyTasks: {},
      selectedDays: [false, false, false, false, false, false, false],
      taskSchemas: [],
      loggedUser: null,
      preferredLocale: Locale("pt"),
    );
  }

  AppState copyWith({
    bool isLoading,
    final Map<String, List<Task>> monthlyTasks,
    List<bool> selectedDays,
    List<TaskSchema> taskSchemas,
    User loggedUser,
    Locale preferredLocale,
  }) {
    return AppState(
      monthlyTasks: monthlyTasks ?? this.monthlyTasks,
      selectedDays: selectedDays ?? this.selectedDays,
      taskSchemas: taskSchemas ?? this.taskSchemas,
      loggedUser: loggedUser ?? this.loggedUser,
      preferredLocale: preferredLocale ?? this.preferredLocale,
    );
  }

  @override
  int get hashCode =>
      monthlyTasks.hashCode ^
      selectedDays.hashCode ^
      loggedUser.hashCode ^
      taskSchemas.hashCode ^
      loggedUser.hashCode ^
      preferredLocale.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          monthlyTasks == other.monthlyTasks &&
          selectedDays == other.selectedDays &&
          taskSchemas == other.taskSchemas &&
          loggedUser == other.loggedUser &&
          preferredLocale == other.preferredLocale;

  @override
  String toString() {
    return 'AppState{monthlyTasks: $monthlyTasks, selectedDays: $selectedDays, '
        'taskSchemas: $taskSchemas, LoggedUser: $loggedUser, '
        'preferedLocale: $preferredLocale}';
  }
}
