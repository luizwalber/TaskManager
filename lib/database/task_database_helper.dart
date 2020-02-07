import 'package:collection/collection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/database/database_helper.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/utils/date_utils.dart';
import 'package:task_manager/utils/enums.dart';

class TaskDatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper();

  /// inserts a task in the database
  Future<int> insert(Task task) async {
    Database db = await _instance.database;
    Map<String, dynamic> row = task.toMap();

    return await db.insert(Task.table, row);
  }

  /// get the tasks in the month and in the previous and next to show tasks outside month but visible in the widget
  /// also converts the rows to the map used in the state
  Future<Map<String, List<Task>>> getTasksNearMonthTasks(int month) async {
    Database db = await _instance.database;
    List<Task> taskList = [];
    String sql =
        '''(${Task.monthCol} = ? or ${Task.monthCol} = ? or ${Task.monthCol} = ?)
        or (${Task.frequencyCol} = ?)
        '''; //TODO && !são com frequencia especial

    List<Map<String, dynamic>> databaseReturn = await db.query(Task.table,
        where: sql,
        whereArgs: [
          month - 1,
          month,
          month + 1,
          TaskFrequency.EVERY_DAY.toString()
        ]);

    databaseReturn.forEach((Map<String, dynamic> taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });

    return groupBy(taskList, (task) => dateDayHash(task.createdForDay));
  }

  /// updates a task in the database
  Future<int> update(Task task) async {
    Database db = await _instance.database;
    Map<String, dynamic> row = task.toMap();
    return await db.update(Task.table, row,
        where: '${Task.idCol} = ?', whereArgs: [task.id]);
  }

  /// deletes a task from the database
  Future<int> delete(int id) async {
    Database db = await _instance.database;
    return await db
        .delete(Task.table, where: '${Task.idCol} = ?', whereArgs: [id]);
  }
}
