import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager/model/app_state.dart';

/// Task to update monthly tasks in State based on a list of tasks
class ChangeSelectedDayAction extends ReduxAction<AppState> {
  final DateTime selectedDay;

  ChangeSelectedDayAction({@required this.selectedDay})
      : assert(selectedDay != null);
      
  @override
  AppState reduce() {
    return state.copyWith(
      selectedDay: selectedDay,
    );
  }
}
