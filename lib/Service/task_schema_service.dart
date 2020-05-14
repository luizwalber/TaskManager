import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/model/task_schema.dart';
import 'package:task_manager/redux/actions/load_task_schemas_action.dart';

/// Service to isolate the actions for the Task Schema
class TaskSchemaService {
  static const String path = 'task_schema';

  final Firestore firestore = Firestore.instance;

  TaskSchemaService._();

  static TaskSchemaService _instance;

  static TaskSchemaService get instance {
    return _instance ??= TaskSchemaService._();
  }

  Future<TaskSchema> addTaskSchema(TaskSchema taskSchema) async {
    try {
      final reference =
          await firestore.collection(path).reference().add(taskSchema.toMap());

      taskSchema.id = reference.documentID;
    } catch (e) {
      print(e.toString());
    }
    return taskSchema;
  }

  Future<void> updateTaskSchema(TaskSchema taskSchema) async {
    final reference = await firestore
        .collection(path)
        .document(taskSchema.id)
        .setData(taskSchema.toMap());

    return reference;
  }

  Future<void> deleteTaskSchema(String id) async {
    final reference = await firestore.collection(path).document(id).delete();
    return reference;
  }

  Stream<List<TaskSchema>> getAllTaskSchema() {
    final result = firestore.collection(path).snapshots().map((snapshot) {
      return snapshot.documents.map((doc) {
        return TaskSchema.fromFirestore(doc);
      }).toList();
    });

    return result;
  }

  void startTaskSchemaListener(String userId) {
    getAllTaskSchema().listen((taskSchemas) {
      store.dispatch(LoadTaskSchemaAction(taskSchemas: taskSchemas));
    });
  }
}
