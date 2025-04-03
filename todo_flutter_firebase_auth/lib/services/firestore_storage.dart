import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_flutter/model/task.dart';
import '../controllers/auth_controller.dart';
import 'storage.dart';

class FirestoreStorage implements Storage {
  CollectionReference _getTasksCollection() {
    final userId = AuthController().userId;
    if (userId == null) {
      throw Exception('User not logged in');
    }
    return FirebaseFirestore.instance.collection('users/$userId/tasks');
  }

  @override
  Future<void> initialize() => Future.value();

  @override
  Stream<List<Task>> getTasks() {
    try {
      return _getTasksCollection().snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Task(
            id: doc.id,
            description: data['description'] as String,
          )..isCompleted = data['isCompleted'] as bool? ?? false;
        }).toList();
      });
    } catch (e) {
      return Stream.value([]);
    }
  }

  @override
  Future<void> insertTask(String description) async {
    try {
      final newTask = Task(description: description);
      await _getTasksCollection().doc(newTask.id).set({
        'description': newTask.description,
        'isCompleted': newTask.isCompleted,
      });
    } catch (e) {
      print('Error inserting task: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeTask(Task task) async {
    try {
      await _getTasksCollection().doc(task.id).delete();
    } catch (e) {
      print('Error removing task: $e');
      rethrow;
    }
  }
}