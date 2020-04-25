// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:redux/redux.dart';
import 'package:task_manager/middleware/locale_middleware.dart';
import 'package:task_manager/middleware/task_middleware.dart';
import 'package:task_manager/middleware/task_schema_middleware.dart';
import 'package:task_manager/middleware/user_middleware.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/repository/locale_repository.dart';
import 'package:task_manager/repository/task_repository.dart';
import 'package:task_manager/repository/task_schema_repository.dart';
import 'package:task_manager/repository/user_repository.dart';

List<Middleware<AppState>> taskMiddleware(
  TaskRepository taskRepository,
  TaskSchemaRepository taskSchemaRepository,
  UserRepository userRepository,
  LocaleRepository localeRepository,
) {
  return [
    TypedMiddleware<AppState, InitAppAction>(
      firestoreSignIn(userRepository),
    ),

    /// ============== TASK ACTIONS ==================
    TypedMiddleware<AppState, DeleteTaskAction>(
      firestoreDeleteTask(taskRepository),
    ),
    TypedMiddleware<AppState, AddTaskAction>(
      firestoreAddTask(taskRepository),
    ),
    TypedMiddleware<AppState, UpdateTaskAction>(
      firestoreUpdateTask(taskRepository),
    ),
    TypedMiddleware<AppState, StartTaskListener>(
      listenMonthTasks(taskRepository),
    ),

    /// =========== TASK SCHEMA ACTIONS ===============
    TypedMiddleware<AppState, AddTaskSchemaAction>(
      firestoreAddTaskSchema(taskSchemaRepository, taskRepository),
    ),
    TypedMiddleware<AppState, UpdateTaskSchemaAction>(
      firestoreUpdateTaskSchema(taskSchemaRepository, taskRepository),
    ),
    TypedMiddleware<AppState, DeleteTaskSchemaAction>(
      firestoreDeleteTaskSchema(taskSchemaRepository),
    ),
    TypedMiddleware<AppState, StartSchemaListener>(
      listenTaskSchema(taskSchemaRepository),
    ),
    TypedMiddleware<AppState, ChangeMonthAction>(
      firestoreChangeMonth(taskSchemaRepository),
    ),

    /// =========== Locale ACTIONS ===============
    TypedMiddleware<AppState, GetLocaleAction>(
      fetchLocale(localeRepository),
    ),
    TypedMiddleware<AppState, ChangeLocaleAction>(
      changeLocale(localeRepository),
    ),
  ];
}
