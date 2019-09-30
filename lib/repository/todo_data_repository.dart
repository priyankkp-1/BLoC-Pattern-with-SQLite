import 'package:flutter_bloc_with_sqlite/dao/todo_data_dao.dart';
import 'package:flutter_bloc_with_sqlite/model/todo_task.dart';

class TodoDataRepository {
  final todoDataDao = TodoDataDao();

  Future getAllTodosData({String query}) =>
      todoDataDao.getTodosData(query: query);

  Future insertTodoData(Todo todo) => todoDataDao.createTodo(todo);

  Future updateTodoData(Todo todo) => todoDataDao.updateTodosData(todo);

  Future deleteTodoDataByIds(int id) => todoDataDao.deleteTodosData(id);

  Future deleteAllTodoData() => todoDataDao.deleteAllTodosData();
}
