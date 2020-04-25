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
import 'package:task_manager/utils/date_utils.dart';
import 'package:task_manager/utils/enums.dart';

class TaskService implements TaskRepository {
  static const String path = 'task';

  final Firestore firestore;

  const TaskService(this.firestore);

  static TaskSchemaRepository taskSchemaRepository =
      TaskSchemaService(Firestore.instance);

  @override
  Future<Task> addTask(Task task) async {
    final reference =
        await firestore.collection(path).reference().add(task.toMap());
    task.id = reference.documentID;
    return task;
  }

  @override
  Future<void> updateTask(Task task) {
    return firestore.collection(path).document(task.id).setData(task.toMap());
  }

  @override
  Future<void> deleteTask(String schemaId) async {
    var futures = <Future>[];

    firestore
        .collection(path)
        .where("schemaId", isEqualTo: schemaId)
        .getDocuments()
        .then((value) => value.documents.forEach((element) {
              futures.add(element.reference.delete());
            }));
    taskSchemaRepository.deleteTaskSchema(schemaId);
    return Future.wait(futures);
  }

  @override
  Stream<List<Task>> getTasks(String userId) {
    // get the tasks since 7 days before the start of the month and 7 days after
//    DateTime start = new DateTime(2020, 03, 01).subtract(Duration(days: 7));
//    DateTime end = new DateTime(2020, 03 + 1, 07);

    return firestore
        .collection(path)
//        .where("createdBy", isEqualTo: "")
//        .where("day", isGreaterThan: start.microsecondsSinceEpoch)
//        .where("day", isLessThanOrEqualTo: end.microsecondsSinceEpoch) TODO
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) {
        return Task.fromFirestore(doc);
      }).toList();
    }); // bad code, I know, TODO think latter
  }

  @override
  Future<void> processTasksFromSchema(TaskSchema taskSchema) {
    var futures = <Future>[];
    for (var monthHash in taskSchema.processedInMonths.keys) {
      if (taskSchema.processedInMonths[monthHash]) {
        int year = int.parse(monthHash.split("-")[0]);
        int initialMonth = int.parse(monthHash.split("-")[1]);

        DateTime date = new DateTime(year, initialMonth, 1);
        int currentMonth;
        do {
          if (_canCreateTask(date, taskSchema)) {
            Task task = Task(
              schemaId: taskSchema.id,
              title: taskSchema.title,
              description: taskSchema.description,
              day: date,
              useLocation: taskSchema.useLocation,
              useAlarm: taskSchema.useAlarm,
              createdBy: taskSchema.createdBy,
            );
            futures.add(addTask(task));
          }
          date = date.add(Duration(days: 1));
          currentMonth = date.month;
          taskSchema.processedInMonths[monthHash] = false;
        } while (currentMonth == initialMonth);
      }
    }
    futures.add(taskSchemaRepository.updateTaskSchema(taskSchema));
    return Future.wait(futures);
  }

  bool _canCreateTask(DateTime currentDate, TaskSchema taskSchema) {
    DateTime createdDate = DateTime(
      taskSchema.createdDay.year,
      taskSchema.createdDay.month,
      taskSchema.createdDay.day,
    );

    if (currentDate.isBefore(createdDate)) {
      return false;
    }

    switch (taskSchema.frequency) {
      case TaskFrequency.ONCE:
        return dateDayHash(currentDate) == dateDayHash(createdDate);
      case TaskFrequency.DAILY:
        return true;
      case TaskFrequency.WEEKLY:
        return currentDate.weekday == createdDate.weekday;
      case TaskFrequency.MONTHLY:
        return currentDate.day == createdDate.day;
      case TaskFrequency.CUSTOM:
        return false;
      case TaskFrequency.ANNUALLY:
        return currentDate.day == createdDate.day &&
            currentDate.month == createdDate.month;
    }
    return false;
  }
}
