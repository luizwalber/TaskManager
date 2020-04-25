// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "accept" : MessageLookupByLibrary.simpleMessage("Accept"),
    "annually" : MessageLookupByLibrary.simpleMessage("Annually"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "currentLanguage" : MessageLookupByLibrary.simpleMessage("Current language: "),
    "custom" : MessageLookupByLibrary.simpleMessage("Custom"),
    "daily" : MessageLookupByLibrary.simpleMessage("Daily"),
    "deleteSchemaDescription" : MessageLookupByLibrary.simpleMessage("Are you sure you want to delete the task "),
    "deleteSchemaTitle" : MessageLookupByLibrary.simpleMessage("Delete Task"),
    "english" : MessageLookupByLibrary.simpleMessage("English"),
    "frequency" : MessageLookupByLibrary.simpleMessage("Frequency"),
    "language" : MessageLookupByLibrary.simpleMessage("Language"),
    "monthly" : MessageLookupByLibrary.simpleMessage("Monthly"),
    "once" : MessageLookupByLibrary.simpleMessage("Once"),
    "portuguese" : MessageLookupByLibrary.simpleMessage("Portuguese"),
    "repeat" : MessageLookupByLibrary.simpleMessage("Repeat"),
    "setLocation" : MessageLookupByLibrary.simpleMessage("Set Location"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "submitTask" : MessageLookupByLibrary.simpleMessage("Submit Task"),
    "taskDescriptionLabel" : MessageLookupByLibrary.simpleMessage("Description"),
    "taskDescriptionPlaceholder" : MessageLookupByLibrary.simpleMessage("What is the task description"),
    "taskDialog" : MessageLookupByLibrary.simpleMessage("Task Dialog"),
    "taskManagerTitle" : MessageLookupByLibrary.simpleMessage("Task Manager"),
    "taskTitleLabel" : MessageLookupByLibrary.simpleMessage("Title *"),
    "taskTitlePlaceholder" : MessageLookupByLibrary.simpleMessage("What is the title?"),
    "titleEmpty" : MessageLookupByLibrary.simpleMessage("Title must not be empty"),
    "useLocation" : MessageLookupByLibrary.simpleMessage("Use Location"),
    "weekly" : MessageLookupByLibrary.simpleMessage("Weekly")
  };
}
