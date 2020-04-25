// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:redux/redux.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/repository/task_repository.dart';

var monthListener;

void Function(
  Store<AppState> store,
  StartTaskListener action,
  NextDispatcher next,
) listenMonthTasks(
  TaskRepository repository,
) {
  return (store, action, next) {
    next(action);
    EasyLoading.show();
    repository.getTasks(store.state.loggedUser.id).listen((tasks) {
      store.dispatch(LoadTasksAction(tasks));
      EasyLoading.dismiss();
    }).onError((error) {
      print("\n\nhere\n\n");
      EasyLoading.dismiss();
    });
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
    EasyLoading.show();
    repository.addTask(action.task).then((value) => EasyLoading.dismiss());
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
    repository
        .deleteTask(action.schemaId)
        .then((value) => store.dispatch(AddTaskInState));
  };
}
