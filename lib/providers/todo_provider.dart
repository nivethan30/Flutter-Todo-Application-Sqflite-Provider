import 'package:flutter/material.dart';
import 'package:todo_sqflite/database/table_structure.dart';
import '../database/query.dart';
import '../model/todo.dart';

class TodoProvider extends ChangeNotifier {
  final DatabaseQuery _query = DatabaseQuery();
  bool isLoading = false;
  late List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  final TextEditingController todoIdController = TextEditingController();
  final TextEditingController todoNameController = TextEditingController();
  bool isDone = false;
  final createdOn = DateTime.now();
  final updatedOn = DateTime.now();

  Future<void> getTodo() async {
    try {
      isLoading = true;
      notifyListeners();
      final todos = await _query.getTodos();
      _todos = todos.map((todo) => Todo.fromMap(todo)).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> insertTodo() async {
    try {
      Todo addTodo = Todo(
          todoName: todoNameController.text,
          createdOn: createdOn.toIso8601String(),
          updatedOn: updatedOn.toIso8601String(),
          isDone: 0);
      final resp = await _query.createTodo(addTodo);
      return resp;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateTodo() async {
    try {
      final int id = int.parse(todoIdController.text);
      Map<String, dynamic> todo = {
        TodoColumns.todoName: todoNameController.text,
        TodoColumns.updatedOn: updatedOn.toIso8601String(),
        TodoColumns.isDone: (isDone == false) ? 0 : 1,
      };
      final resp = await _query.updateTodo(id, todo);
      return resp;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteTodo(int todoId) async {
    try {
      final resp = await _query.deleteTodo(todoId);
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
