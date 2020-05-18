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
  }) : super(equals: [user,selectedDays]);

  @override
  SubmitSchemaViewModel fromStore() => SubmitSchemaViewModel.build(
        user: state.user,
        selectedDays: state.selectedDays,
      );
}
