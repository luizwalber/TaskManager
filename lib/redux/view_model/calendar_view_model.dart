import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';
import 'package:task_manager/redux/actions/change_selected_day_action.dart';

/// Helper to holds part of the state info
class CalendarViewModel extends BaseModel<AppState> {
  Map<String, List<Task>> monthlyTasks;
  List<TaskSchema> taskSchemas;

  Function(DateTime) changeSelectedDay;

  CalendarViewModel();

  CalendarViewModel.build({
    @required this.monthlyTasks,
    @required this.taskSchemas,
    @required this.changeSelectedDay,
  }) : super(equals: [monthlyTasks, taskSchemas]);

  @override
  CalendarViewModel fromStore() {
    return CalendarViewModel.build(
      /*  */
      monthlyTasks: state.monthlyTasks,
      taskSchemas: state.taskSchemas,
      changeSelectedDay: (DateTime selectedDay) =>
          dispatch(ChangeSelectedDayAction(selectedDay:selectedDay)),
    );
  }
}
