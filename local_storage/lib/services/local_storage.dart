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
  }

}

