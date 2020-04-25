enum TaskStatus { DONE, PARTIALLY, NOT_DONE, EMPTY }
enum TaskFrequency { DAILY, WEEKLY, MONTHLY, CUSTOM, ONCE, ANNUALLY }
enum ConfirmAction { ACCEPT, CANCEL }

T stringToEnum<T>(Iterable<T> values, String value) {
  return values?.firstWhere((type) => type?.toString() == value,
      orElse: () => null);
}

/// I tried this way before, but it wasn't recognizing enumType as the enums, will come back latter to see this TODO
//stringToEnum(enumType, String s) {
//  if (enumType is TaskStatus)
//    return TaskStatus.values.firstWhere((e) => e.toString() == s);
//  else if (enumType is TaskFrequency)
//    return TaskFrequency.values.firstWhere((e) => e.toString() == s);
//}
