import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:redux/redux.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task_schema.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/repository/task_repository.dart';
import 'package:task_manager/repository/task_schema_repository.dart';
import 'package:task_manager/utils/date_utils.dart';

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

    EasyLoading.show();

    schemaRepository.addTaskSchema(action.taskSchema).then((createdSchema) {
      taskRepository.processTasksFromSchema(createdSchema).then((value) {
        schemaRepository.updateTaskSchema(createdSchema);
        EasyLoading.dismiss();
      });
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
    EasyLoading.show();

    TaskSchema updatedSchema = action.taskSchema;

    schemaRepository.updateTaskSchema(updatedSchema).then((empty) {
      taskRepository.processTasksFromSchema(updatedSchema).then((value) {
        EasyLoading.dismiss();
      });
    });
  };
}

void Function(
  Store<AppState> store,
  ChangeMonthAction action,
  NextDispatcher next,
) firestoreChangeMonth(
  TaskSchemaRepository schemaRepository,
) {
  return (store, action, next) {
    next(action);
    for (TaskSchema currentSchema in store.state.taskSchemas) {
      String currentMonthHash =
          dateMonthHash(new DateTime(action.year, action.month));
      String nextMonthHash =
          dateMonthHash(new DateTime(action.year, action.month + 1));
      String previousMonthHash =
          dateMonthHash(new DateTime(action.year, action.month - 1));

      currentSchema.processedInMonths.putIfAbsent(currentMonthHash, () => true);
      currentSchema.processedInMonths.putIfAbsent(nextMonthHash, () => true);
      currentSchema.processedInMonths
          .putIfAbsent(previousMonthHash, () => true);

      store.dispatch(UpdateTaskSchemaAction(currentSchema));
    }
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
