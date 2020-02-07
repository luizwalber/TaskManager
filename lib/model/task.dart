import 'package:task_manager/model/weekdays.dart';
import 'package:task_manager/utils/enums.dart';

class Task {
  int id;
  String title;
  DateTime createdForDay;
  TaskFrequency frequency;
  TaskStatus status;
  String timeSpent;
  bool useLocation;
  String location;
  List<bool> selectedDays;
  String description;
  int month;

  /// I need to Query the events by the months to avoid loading all of them every time
  /// but SqfLite doesn't support Dates, I didn't know any way other than this to do this query

  /// didn't find a better way to access the column with sqflite
  static final String table = "task";

  static final String idCol = "id";
  static final String createdForDayCol = "day";
  static final String titleCol = "title";
  static final String statusCol = "status";
  static final String timeSpentCol = "time_spent";
  static final String useLocationCol = "use_location";
  static final String locationCol = "location";
  static final String frequencyCol = "frequency";
  static final String descriptionCol = "description";
  static final String monthCol = "month";

  Task(
      {this.id,
      this.createdForDay,
      this.title,
      this.status,
      this.timeSpent,
      this.frequency,
      this.selectedDays,
      this.location,
      this.useLocation,
      this.description,
      this.month});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {
      idCol: id,
      createdForDayCol: createdForDay.toIso8601String(),
      titleCol: title, // TODO when testing check null variables
      statusCol: status.toString(),
      timeSpentCol: timeSpent.toString(),
      frequencyCol: frequency.toString(),
      useLocationCol: useLocation,
      locationCol: location,
      descriptionCol: description,
      monthCol: month
    };

    if (selectedDays != null && selectedDays.length == 7)
      result.addAll(Weekdays(selectedDays).toMap());

    return result;
  }

  Task.fromMap(Map<String, dynamic> map) {
    this.id = map[idCol];
    this.createdForDay = DateTime.parse(map[createdForDayCol]);
    this.title = map[titleCol];
    this.status = stringToEnum(TaskStatus, map[statusCol]);
    this.timeSpent = map[timeSpentCol];
    this.frequency = stringToEnum(TaskStatus, map[frequencyCol]);
    this.useLocation = map[useLocationCol] != 0;
    this.location = map[locationCol];
    this.description = map[descriptionCol];
    this.month = map[monthCol];
    this.selectedDays = Weekdays.fromMap(map).selectedDays;
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Task && other.id == id;
}
