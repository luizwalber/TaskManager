import 'package:flutter/foundation.dart';
import 'package:task_manager/model/User.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';
import 'package:task_manager/model/user_preferences.dart';

@immutable
class AppState {
  final Map<String, List<Task>> monthlyTasks;
  final List<TaskSchema> taskSchemas;
  final User user;
  final bool loading;
  final UserPreferences userPreferences;
  final DateTime selectedDay;

  final List<bool> selectedDays;

  AppState(
      {@required this.monthlyTasks,
      @required this.selectedDays,
      @required this.taskSchemas,
      @required this.user,
      @required this.loading,
      @required this.userPreferences,
      @required this.selectedDay});

  factory AppState.initial() {
    return AppState(
      monthlyTasks: {},
      selectedDays: [false, false, false, false, false, false, false],
      taskSchemas: [],
      user: null,
      loading: true,
      userPreferences: UserPreferences.initial(),
      selectedDay: DateTime.now(),
    );
  }

  AppState copyWith({
    bool isLoading,
    final Map<String, List<Task>> monthlyTasks,
    List<bool> selectedDays,
    List<TaskSchema> taskSchemas,
    User loggedUser,
    bool loading,
    UserPreferences userPreferences,
    DateTime selectedDay,
  }) {
    return AppState(
      monthlyTasks: monthlyTasks ?? this.monthlyTasks,
      selectedDays: selectedDays ?? this.selectedDays,
      taskSchemas: taskSchemas ?? this.taskSchemas,
      user: loggedUser ?? this.user,
      loading: loading ?? this.loading,
      userPreferences: userPreferences ?? this.userPreferences,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  @override
  int get hashCode =>
      monthlyTasks.hashCode ^
      selectedDays.hashCode ^
      user.hashCode ^
      taskSchemas.hashCode ^
      loading.hashCode ^
      userPreferences.hashCode ^
      selectedDay.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          monthlyTasks == other.monthlyTasks &&
          selectedDays == other.selectedDays &&
          taskSchemas == other.taskSchemas &&
          user == other.user &&
          loading == other.loading &&
          userPreferences == other.userPreferences &&
          selectedDay == other.selectedDay;

  @override
  String toString() {
    return '''AppState{ 
    monthlyTasks: $monthlyTasks, 
    selectedDays: $selectedDays, 
    taskSchemas: $taskSchemas, 
    LoggedUser: $user, 
    loading: $loading,
    UserPreferences: $userPreferences,
    selectedDay: $selectedDay
    }''';
  }
}
