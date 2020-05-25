


import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/model/app_state.dart';

/// Helper to holds part of the state info
class SelectedDayViewModel extends BaseModel<AppState> {
  DateTime selectedDay;

  SelectedDayViewModel();

  SelectedDayViewModel.build({
    @required this.selectedDay,
  }) : super(equals: [selectedDay]);

  @override
  SelectedDayViewModel fromStore() {
    return SelectedDayViewModel.build(
      selectedDay: state.selectedDay,
    );
  }
}
