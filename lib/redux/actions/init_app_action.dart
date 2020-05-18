import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Service/startup_service.dart';
import 'package:task_manager/model/app_state.dart';

/// This action to initialize the app
class InitAppAction extends ReduxAction<AppState> {
  final BuildContext context;

  InitAppAction({@required this.context}) : assert(context != null);
  
  @override
  Future<AppState> reduce() async {
    return state.copyWith(
        loading: await StartupService.instance.startupApp(context));
  }
}
