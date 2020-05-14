import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_manager/model/app_state.dart';

/// Task to update monthly tasks in State based on a list of tasks
class ChangeSelectedDayAction extends ReduxAction<AppState> {
  final DateTime selectedDay;

  ChangeSelectedDayAction({@required this.selectedDay})
      : assert(selectedDay != null);

  void before() {
    EasyLoading.show();
  }

  void after() {
    EasyLoading.dismiss();
  }

  @override
  AppState reduce() {
    return state.copyWith(
      selectedDay: selectedDay,
    );
  }
}
