import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:redux/redux.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/repository/user_repository.dart';

void Function(
  Store<AppState> store,
  InitAppAction action,
  NextDispatcher next,
) firestoreSignIn(
  UserRepository repository,
) {
  return (store, action, next) {
    next(action);

    EasyLoading.instance..userInteractions = false;

    repository.login().then((loggedUser) {
      store.dispatch(LoadUserAction(loggedUser));
      store.dispatch(StartTaskListener());
      store.dispatch(StartSchemaListener());
    });
  };
}
