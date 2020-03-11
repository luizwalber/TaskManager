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

    repository.login().then((_) {
      store.dispatch(
          GetTasksNearMonth(DateTime.now().month, DateTime.now().year));
      store.dispatch(StartSchemaListener());
    });
  };
}
