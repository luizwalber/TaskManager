enum TaskStatus { FINISHED, ON_GOING, NOT_DONE }
enum TaskFrequency { DAILY, WEEKLY, MONTHLY, CUSTOM, EVERY_DAY, ONCE }

stringToEnum(enumType, String s) {
  if (enumType is TaskStatus)
    return TaskStatus.values
        .firstWhere((e) => e.toString() == 'TaskStatus.' + s);
  else if (enumType is TaskFrequency)
    return TaskFrequency.values
        .firstWhere((e) => e.toString() == 'TaskFrequency.' + s);
}
