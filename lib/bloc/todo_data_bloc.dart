import 'dart:async';

import 'package:flutter_bloc_with_sqlite/model/todo_task.dart';
import 'package:flutter_bloc_with_sqlite/repository/todo_data_repository.dart';

class TodoDataBloc {
  final _todoDataRepository = TodoDataRepository();

  final _todoDataController = StreamController<List<Todo>>.broadcast();

  get todos => _todoDataController.stream;

  TodoDataBloc() {
    getTodosData();
  }

  addTodosData(Todo todo) async {
    await _todoDataRepository.insertTodoData(todo);
    getTodosData();
  }

  getTodosData({String query}) async {
    _todoDataController.sink
        .add(await _todoDataRepository.getAllTodosData(query: query));
  }

  deleteTodosDataById(int id) async {
    _todoDataRepository.deleteTodoDataByIds(id);
    getTodosData();
  }

  updateTodosData(Todo todo) async {
    await _todoDataRepository.updateTodoData(todo);
    getTodosData();
  }

  dispose() {
    _todoDataController.close();
  }
}
