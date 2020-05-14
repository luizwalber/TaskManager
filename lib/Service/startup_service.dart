import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_manager/Service/task_schema_service.dart';
import 'package:task_manager/Service/task_service.dart';
import 'package:task_manager/Service/user_service.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/model/User.dart';
import 'package:task_manager/redux/actions/load_user_action.dart';
import 'package:task_manager/redux/actions/load_user_preferences_action.dart';

/// Service to isolate the actions for the app startup
class StartupService {
  static const String path = 'task_schema';

  final Firestore firestore = Firestore.instance;

  StartupService._();

  static StartupService _instance;

  static StartupService get instance {
    return _instance ??= StartupService._();
  }

  Future<bool> startupApp(BuildContext context) async {
    EasyLoading.instance..userInteractions = false;

    User user = await UserService.instance.login();
    // TODO load user preferences
    store.dispatch(LoadUserAction(loggedUser: user));
    TaskService.instance.startTaskListener(user.id);
    TaskSchemaService.instance.startTaskSchemaListener(user.id);
    store.dispatch(LoadUserPreferencesAction(context: context));

    return true;
  }
}
