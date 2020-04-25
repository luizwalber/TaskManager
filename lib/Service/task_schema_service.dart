import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/Service/task_service.dart';
import 'package:task_manager/model/task_schema.dart';
import 'package:task_manager/repository/task_repository.dart';
import 'package:task_manager/repository/task_schema_repository.dart';

class TaskSchemaService implements TaskSchemaRepository {
  static const String path = 'task_schema';
  static TaskRepository taskRepository = TaskService(Firestore.instance);

  final Firestore firestore;

  const TaskSchemaService(this.firestore);

  Future<TaskSchema> addTaskSchema(TaskSchema taskSchema) async {
    final reference =
        await firestore.collection(path).reference().add(taskSchema.toMap());
    taskSchema.id = reference.documentID;
    return taskSchema;
  }

  @override
  Future<void> updateTaskSchema(TaskSchema taskSchema) {
    return firestore
        .collection(path)
        .document(taskSchema.id)
        .setData(taskSchema.toMap());
  }

  @override
  Future<void> deleteTaskSchema(String id) {
    return firestore.collection(path).document(id).delete();
  }

  @override
  Stream<List<TaskSchema>> getAllTaskSchema() {
    return firestore.collection(path).snapshots().map((snapshot) {
      return snapshot.documents.map((doc) {
        return TaskSchema.fromFirestore(doc);
      }).toList();
    });
  }
}
