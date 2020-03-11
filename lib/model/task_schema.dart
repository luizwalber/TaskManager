import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/utils/enums.dart';

/// When creating a task, you actually create a schema for this task and this schema is processed adding the tasks in the months
class TaskSchema {
  String id;
  String title;
  String description;
  DateTime createdDay;
  TaskFrequency frequency;
  bool useLocation;
  String location;
  Map<String, bool> selectedDays;
  bool useAlarm;
  String alarmTime;
  String alarmRingtone;
  Map<String, bool> processedInMonths;

  /// [processedInMonths] the key is a hash to represent the month and the value is a boolean indicating if this month needs to be processed

  static final String table = "task_schema";

  static final String idCol = "id";
  static final String titleCol = "title";
  static final String descriptionCol = "description";
  static final String createdDayCol = "createdDay";
  static final String frequencyCol = "frequency";
  static final String useLocationCol = "useLocation";
  static final String locationCol = "location";
  static final String selectedDaysCol = "selectedDays";
  static final String useAlarmCol = "useAlarm";
  static final String alarmTimeCol = "alarmTime";
  static final String alarmRingtoneCol = "alarmRingtone";
  static final String processedInMonthsCol = "processedInMonths";

  TaskSchema(
      {this.id,
      this.title,
      this.description,
      this.createdDay,
      this.frequency,
      this.useLocation,
      this.location,
      this.selectedDays,
      this.useAlarm,
      this.alarmRingtone,
      this.alarmTime,
      this.processedInMonths});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {};

    // doing this way I can sent only the not null data, in the future I'll add exceptions like 'title' must not be null etc etc
    if (id != null) result[idCol] = id;
    if (title != null) result[titleCol] = title;
    if (description != null) result[descriptionCol] = description;
    if (createdDay != null)
      result[createdDayCol] = Timestamp.fromMicrosecondsSinceEpoch(
          createdDay.microsecondsSinceEpoch);
    if (frequency != null) result[frequencyCol] = frequency.toString();
    if (useLocation != null) result[useLocationCol] = useLocation;
    if (location != null) result[locationCol] = location;
    if (useAlarm != null) result[useAlarmCol] = useAlarm;
    if (alarmTime != null) result[alarmTimeCol] = alarmTime;
    if (alarmRingtone != null) result[alarmRingtoneCol] = alarmRingtone;
    if (processedInMonths != null)
      result[processedInMonthsCol] = processedInMonths;
    if (selectedDays != null && selectedDays.length == 7)
      result[selectedDaysCol] = selectedDays;

    return result;
  }

  TaskSchema.fromFirestore(DocumentSnapshot doc) {
    this.id = doc.documentID;
    this.title = doc[titleCol];
    this.description = doc[descriptionCol];
    this.createdDay = DateTime.fromMicrosecondsSinceEpoch(
        doc[createdDayCol].microsecondsSinceEpoch);
    this.frequency = stringToEnum(TaskFrequency.values, doc[frequencyCol]);
    this.useLocation = doc[useLocationCol] ?? false;
    this.location = doc[locationCol];
    this.useAlarm = doc[useAlarmCol] ?? false;
    this.alarmRingtone = doc[alarmRingtoneCol];
    this.alarmTime = doc[alarmTimeCol];
    this.processedInMonths = Map.from(doc[processedInMonthsCol]);
    this.selectedDays = doc[selectedDaysCol];
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is TaskSchema && other.id == id;
}
