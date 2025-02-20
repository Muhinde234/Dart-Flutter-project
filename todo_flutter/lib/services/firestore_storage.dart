import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_flutter/model/task.dart';

import 'storage.dart';

class FirestoreStorage implements Storage {

  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('Tasks');

  @override
  Future<void> initialize() => Future.value();

  @override
  Stream<List<Task>> getTasks() {
    return tasksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Task(
          id: doc.id,
          description: data['description'] as String,
        )..isCompleted = data['isCompleted'] as bool? ?? false;
      }).toList();
    });
  }

  @override
  Future<void> insertTask(String description) async {
    final newTask = Task(description: description);
    await tasksCollection.doc(newTask.id).set({
      'description': newTask.description,
      'isCompleted': newTask.isCompleted,
    });
  }

  @override
  Future<void> removeTask(Task task) async {
    await tasksCollection.doc(task.id).delete();
  }

}
