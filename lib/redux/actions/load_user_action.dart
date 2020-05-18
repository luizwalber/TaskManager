import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_manager/model/User.dart';
import 'package:task_manager/model/app_state.dart';

/// Task to update monthly tasks in State based on a list of tasks
class LoadUserAction extends ReduxAction<AppState> {
  final User loggedUser;

  LoadUserAction({@required this.loggedUser}) : assert(loggedUser != null);

  @override
  AppState reduce() {
    return state.copyWith(
      loggedUser: loggedUser,
    );
  }
}
