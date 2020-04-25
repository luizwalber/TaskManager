import 'package:redux/redux.dart';
import 'package:task_manager/model/User.dart';
import 'package:task_manager/redux/actions/actions.dart';

final userReducer = combineReducers<User>([
  TypedReducer<User, LoadUserAction>(_updateLoggedUser),
]);

User _updateLoggedUser(User user, LoadUserAction action) {
  return action.user;
}
