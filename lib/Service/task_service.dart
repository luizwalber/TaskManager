// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/Service/task_schema_service.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';
import 'package:task_manager/repository/task_repository.dart';
import 'package:task_manager/repository/task_schema_repository.dart';

class TaskService implements TaskRepository {
  static const String path = 'task';

  final Firestore firestore;

  const TaskService(this.firestore);

  static TaskSchemaRepository taskSchemaRepository =
      TaskSchemaService(Firestore.instance);

  @override
  Future<void> addTask(Task task) {
//    return firestore.collection(path).document(task.id).setData(task.toMap());
    return null;
  }

  @override
  Future<void> updateTask(Task task) {
//    return firestore.collection(path).document(task.id).setData(task.toMap());
    return null;
  }

  @override
  Future<void> deleteTask(String id) async {
    return firestore.collection(path).document(id).delete();
  }

  @override
  Future<List<Task>> getTasksNearMonth(int month, int year) {
    // get the tasks since 7 days before the start of the month and 7 days after
    DateTime start = new DateTime(year, month, 01).subtract(Duration(days: 7));
    DateTime end = new DateTime(year, month + 1, 07);

    return firestore
        .collection(path)
        .where("day", isGreaterThan: start.microsecondsSinceEpoch)
        .where("day", isLessThanOrEqualTo: end.microsecondsSinceEpoch)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) {
        return Task.fromFirestore(doc);
      }).toList();
    }).first; // bad code, I know, TODO think latter
  }

  bool _canCreateTask() {
    return true;
  }

  @override
  Future<void> generateNewTasks(TaskSchema taskSchema) {
    var futures = <Future>[];

    for (var monthHash in taskSchema.processedInMonths.keys) {
      if (taskSchema.processedInMonths[monthHash]) {
        int year = int.parse(monthHash.split("-")[0]);
        int initialMonth = int.parse(monthHash.split("-")[1]);

        DateTime date = new DateTime(year, initialMonth, 1);
        if (_canCreateTask()) {
          int currentMonth;
          do {
            Task task = Task(
              schemaId: taskSchema.id,
              title: taskSchema.title,
              description: taskSchema.description,
              day: date,
              useLocation: taskSchema.useLocation,
              useAlarm: taskSchema.useAlarm,
            );
            futures.add(addTask(task));

            date = date.add(Duration(days: 1));
            currentMonth = date.month;
          } while (currentMonth == initialMonth);
        }
        taskSchema.processedInMonths[monthHash] = false;
      }
    }

    taskSchemaRepository.updateTaskSchema(taskSchema);

    return Future.wait(futures);
  }
}
