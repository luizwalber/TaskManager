// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:redux/redux.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/repository/task_repository.dart';

var monthListener;

//void Function(
//  Store<AppState> store,
//  StartMonthListener action,
//  NextDispatcher next,
//) listenMonthTasks(
//  TaskRepository repository,
//) {
//  return (store, action, next) {
//    next(action);
//
//    monthListener
//        ?.cancel(); // cancels previous listener to avoid unnecessary reads
//    monthListener =
//        repository.getTasks(action.month, action.year).listen((tasks) {
//      store.dispatch(TransformTaskAction(tasks));
//    });
//  };
//}

void Function(
  Store<AppState> store,
  GetTasksNearMonth action,
  NextDispatcher next,
) getTasksNearMonth(
  TaskRepository repository,
) {
  return (store, action, next) {
    next(action);
    repository
        .getTasksNearMonth(action.month, action.year)
        .then((value) => store.dispatch(LoadTasksAction));
  };
}

void Function(
  Store<AppState> store,
  AddTaskAction action,
  NextDispatcher next,
) firestoreAddTask(
  TaskRepository repository,
) {
  return (store, action, next) {
    next(action);
    repository
        .addTask(action.task)
        .then((value) => store.dispatch(AddTaskInState));
  };
}

void Function(
  Store<AppState> store,
  UpdateTaskAction action,
  NextDispatcher next,
) firestoreUpdateTask(
  TaskRepository repository,
) {
  return (store, action, next) {
    next(action);
    repository.updateTask(action.task);
  };
}

void Function(
  Store<AppState> store,
  DeleteTaskAction action,
  NextDispatcher next,
) firestoreDeleteTask(
  TaskRepository repository,
) {
  return (store, action, next) {
    next(action);
    repository.deleteTask(action.id);
  };
}
