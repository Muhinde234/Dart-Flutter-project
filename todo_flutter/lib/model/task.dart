import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Task {
  Task({required this.description, String? id})
      : isCompleted = false,
        id = id ?? _uuid.v1();
  bool isCompleted;
  final String description;
  final String id;
}
