import 'package:redux/redux.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/repository/task_repository.dart';
import 'package:task_manager/repository/task_schema_repository.dart';

void Function(
  Store<AppState> store,
  AddTaskSchemaAction action,
  NextDispatcher next,
) firestoreAddTaskSchema(
  TaskSchemaRepository schemaRepository,
  TaskRepository taskRepository,
) {
  return (store, action, next) {
    next(action);
    store.dispatch(StartLoading);

    schemaRepository.addTaskSchema(action.taskSchema);
    taskRepository.generateNewTasks(action.taskSchema).then((value) {
      store.dispatch(StopLoading);
      store.dispatch(GetTasksNearMonth);
    });
  };
}

void Function(
  Store<AppState> store,
  UpdateTaskSchemaAction action,
  NextDispatcher next,
) firestoreUpdateTaskSchema(
  TaskSchemaRepository schemaRepository,
  TaskRepository taskRepository,
) {
  return (store, action, next) {
    next(action);
    store.dispatch(StartLoading);

    taskRepository
        .generateNewTasks(action.taskSchema)
        .then((value) => store.dispatch(StopLoading));
    schemaRepository.updateTaskSchema(action.taskSchema);
  };
}

void Function(
  Store<AppState> store,
  DeleteTaskSchemaAction action,
  NextDispatcher next,
) firestoreDeleteTaskSchema(
  TaskSchemaRepository repository,
) {
  return (store, action, next) {
    next(action);
    repository.deleteTaskSchema(action.id);
  };
}

void Function(
  Store<AppState> store,
  StartSchemaListener action,
  NextDispatcher next,
) listenTaskSchema(
  TaskSchemaRepository repository,
) {
  return (store, action, next) {
    next(action);

    repository.getAllTaskSchema().listen((taskSchemas) {
      store.dispatch(LoadTaskSchemaAction(taskSchemas));
    });
  };
}
