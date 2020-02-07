import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/weekdays.dart';

class DatabaseHelper {
  static final _databaseName = "TaskManager.db";
  static final _databaseVersion = 2;

  /// has only one reference to the database
  static Database _database;

  /// turns this class singleton
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();

  factory DatabaseHelper() => _instance;

  /// returns an instance for the database
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  /// Open the database (creating if it doesn't exist)
  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, _databaseName);

//    await deleteDatabase(path);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // method to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${Task.table} (
            ${Task.idCol} INTEGER PRIMARY KEY,
            ${Task.titleCol} TEXT NOT NULL,
            ${Task.createdForDayCol} TEXT NOT NULL,
            ${Task.frequencyCol} TEXT NOT NULL,
            ${Task.statusCol} TEXT NOT NULL,
            ${Task.timeSpentCol} TEXT,
            ${Task.useLocationCol} INTEGER NOT NULL,
            ${Task.locationCol} TEXT,
            ${Task.descriptionCol} TEXT,
            ${Task.monthCol} INTEGER NOT NULL,
            ${Weekdays.sundayCol} INTEGER,
            ${Weekdays.tuesdayCol} INTEGER,
            ${Weekdays.wednesdayCol} INTEGER,
            ${Weekdays.thursdayCol} INTEGER,
            ${Weekdays.fridayCol} INTEGER,
            ${Weekdays.saturdayCol} INTEGER,
            ${Weekdays.mondayCol} INTEGER
          );''');
  }
}
