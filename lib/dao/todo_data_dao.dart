import 'package:flutter_bloc_with_sqlite/database/database.dart';
import 'package:flutter_bloc_with_sqlite/model/todo_task.dart';

class TodoDataDao {
  final _dbProvider = DBProvider.dbProvider;

  Future<int> createTodo(Todo todo) async {
    final db = await _dbProvider.database;

    var result = db.insert(todoTableName, todo.toDatabaseJson());
    return result;
  }

  Future<List<Todo>> getTodosData({List<String> column, String query}) async {
    final db = await _dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(todoTableName,
            columns: column,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(todoTableName, columns: column);
    }

    List<Todo> todosData = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];

    return todosData;
  }

  Future<int> updateTodosData(Todo todo) async {
    final db = await _dbProvider.database;

    var result = await db.update(todoTableName, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodosData(int id) async {
    final db = await _dbProvider.database;
    var result =
        await db.delete(todoTableName, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future deleteAllTodosData() async {
    final db = await _dbProvider.database;
    var result = await db.delete(todoTableName);
    return result;
  }
}
