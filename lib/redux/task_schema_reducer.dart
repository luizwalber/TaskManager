import 'package:redux/redux.dart';
import 'package:task_manager/model/task_schema.dart';
import 'package:task_manager/redux/actions/actions.dart';

final taskSchemaReducer = combineReducers<List<TaskSchema>>([
  TypedReducer<List<TaskSchema>, LoadTaskSchemaAction>(_loadTaskSchemas),
]);

List<TaskSchema> _loadTaskSchemas(
    List<TaskSchema> schemas, LoadTaskSchemaAction action) {
  return action.taskSchema;
}
