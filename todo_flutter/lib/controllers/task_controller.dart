import 'package:todo_flutter/services/firestore_storage.dart';

import '../model/task.dart';
import '../services/storage.dart';

class TaskController {
  factory TaskController() => _singleton;

  TaskController._internal();

  static final TaskController _singleton = TaskController._internal();

  final Storage _storage = FirestoreStorage();

  Stream<List<Task>> getStream() => _storage.getTasks();

  Future<void> insertTask(String description) =>
      _storage.insertTask(description);

  Future<void> removeTask(Task task) => _storage.removeTask(task);

  Future<void> initialize() => _storage.initialize();

}
