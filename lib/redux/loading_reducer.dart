import 'package:redux/redux.dart';
import 'package:task_manager/redux/actions/actions.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadTasksAction>(_startLoading),
  TypedReducer<bool, StartLoading>(_startLoading),
  TypedReducer<bool, StopLoading>(_stopLoading),
]);

bool _startLoading(bool state, action) {
  return true;
}

bool _stopLoading(bool state, action) {
  return false;
}
