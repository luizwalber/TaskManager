import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/model/User.dart';
import 'package:task_manager/model/app_state.dart';

/// Helper to holds part of the state info
class SubmitSchemaViewModel extends BaseModel<AppState> {
  SubmitSchemaViewModel();

  User user;

  List<bool> selectedDays;

  SubmitSchemaViewModel.build({
    @required this.user,
    @required this.selectedDays,
  });

  @override
  SubmitSchemaViewModel fromStore() => SubmitSchemaViewModel.build(
        user: state.user,
        selectedDays: state.selectedDays,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is SubmitSchemaViewModel &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          selectedDays == other.selectedDays;

  @override
  int get hashCode => super.hashCode ^ user.hashCode ^ selectedDays.hashCode;
}
