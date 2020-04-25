import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/utils/enums.dart';

/// The actual task event
class Task {
  String id;
  String schemaId;
  String title;
  String description;
  DateTime day;
  TaskStatus status;
  String timeSpent;
  bool useLocation;
  String location;
  bool useAlarm;
  String alarmTime;
  String createdBy;

  static final String table = "task";

  static final String idCol = "id";
  static final String schemaIdCol = "schemaId";
  static final String titleCol = "title";
  static final String descriptionCol = "description";
  static final String dayCol = "day";
  static final String statusCol = "status";
  static final String timeSpentCol = "timeSpent";
  static final String useLocationCol = "useLocation";
  static final String locationCol = "location";
  static final String useAlarmCol = "useAlarm";
  static final String alarmTimeCol = "alarmTime";
  static final String createdByCol = "createdBy";

  Task(
      {this.id,
      this.schemaId,
      this.title,
      this.description,
      this.day,
      this.status,
      this.timeSpent,
      this.useLocation,
      this.location,
      this.useAlarm,
      this.alarmTime,
      this.createdBy});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {};

    // doing this way I can sent only the not null data, in the future I'll add exceptions like 'title' must not be null etc etc
    if (id != null) result[idCol] = id;
    if (title != null) result[titleCol] = title;
    if (schemaId != null) result[schemaIdCol] = schemaId;
    if (description != null) result[descriptionCol] = description;
    if (day != null)
      result[dayCol] =
          Timestamp.fromMicrosecondsSinceEpoch(day.microsecondsSinceEpoch);
    if (status != null) result[statusCol] = status.toString();
    if (timeSpent != null) result[timeSpentCol] = timeSpent;
    if (useLocation != null) result[useLocationCol] = useLocation;
    if (location != null) result[locationCol] = location;
    if (useAlarm != null) result[useAlarmCol] = useAlarm;
    if (alarmTime != null) result[alarmTimeCol] = alarmTime;
    if (createdBy != null) result[createdByCol] = createdBy;
    return result;
  }

  Task.fromFirestore(doc) {
    this.id = doc.documentID;
    this.schemaId = doc[schemaIdCol];
    this.title = doc[titleCol];
    this.description = doc[descriptionCol];
    this.day =
        DateTime.fromMicrosecondsSinceEpoch(doc[dayCol].microsecondsSinceEpoch);
    this.status = stringToEnum(TaskStatus.values, doc[statusCol]);
    this.timeSpent = doc[timeSpentCol];
    this.location = doc[locationCol];
    this.useLocation = doc[useLocationCol] ?? false;
    this.useAlarm = doc[useAlarmCol] ?? false;
    this.alarmTime = doc[alarmTimeCol];
    this.createdBy = doc[createdBy];
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Task && other.id == id;
}
