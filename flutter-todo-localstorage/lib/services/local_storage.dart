import 'package:path/path.dart';
import 'package:sqlbrite/sqlbrite.dart';
import '../model/task.dart';
import 'storage.dart';

class LocalStorage extends Storage {
  late BriteDatabase _database;

  @override
  Future<void> initialize() async {
    final name = join(await getDatabasesPath(), 'todo.db');

    final database = await openDatabase(name, version: 1, onCreate: _onCreate);
    _database = BriteDatabase(database);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Task (id TEXT PRIMARY KEY, description TEXT)"
    );

    final task = Task(description: "First local Task");

    await db.insert(
        "Task",
        {
          "id": task.id,
          "description": task.description
        }
    );

  }

  @override
  Stream<List<Task>> getTasks() {
    return _database.createQuery("Task").mapToList((row) => Task(
      description: row["description"] as String,
      id: row["id"] as String,
    ));
  }

  @override
  Future<void> insertTask(String description) async {
    final task = Task(description: description);
    await _database.insert(
        "Task",
        {
          "id": task.id,
          "description": task.description,
        }
    );
  }

  @override
  Future<void> removeTask(Task task) async {
    await _database.delete(
      "Task",
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

}

