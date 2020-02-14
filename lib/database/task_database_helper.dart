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
  Future<int> updateAll(Task task) async {
    Database db = await _instance.database;

    return await db.update(
      Task.table,
      task.toMap(),
      where: '${Task.idCol} = ?',
      whereArgs: [task.id],
    );
  }

  /// updates a task in the database
  Future<int> updateStatus(int taskId, TaskStatus taskStatus) async {
    Database db = await _instance.database;
    String sql =
        "UPDATE ${Task.table} SET ${Task.statusCol} = ? WHERE ${Task.idCol} = ?";

    ///TODO pq n esta atualizando? fazer uns testes aqui.. isso esta irritando um pouquinho, impede de ver a andamento quando abre isso deixaria o app mais bonito (e tbm é um MUST)

    Map<String, List<Task>> up = await getTasksNearMonthTasks(2);
    int r = await db.rawUpdate(sql, [taskStatus.toString(), taskId]);
    up = await getTasksNearMonthTasks(2);
    print(up);
    return r;
  }

  /// deletes a task from the database
  Future<int> delete(int id) async {
    Database db = await _instance.database;
    return await db.delete(
      Task.table,
      where: '${Task.idCol} = ?',
      whereArgs: [id],
    );
  }
}
