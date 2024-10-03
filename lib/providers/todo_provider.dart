import 'package:flutter/material.dart';
import '../database/query.dart';
import '../model/todo.dart';

class TodoProvider extends ChangeNotifier {
  final DatabaseQuery _query = DatabaseQuery();
  bool isLoading = false;
  late List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  /// Gets all the todos from the database and updates the [_todos] list.
  ///
  /// Sets [isLoading] to true before the operation and false after the
  /// operation. Calls [notifyListeners] after setting [isLoading] to inform
  /// the widgets that depend on this provider to rebuild.
  ///
  /// If the operation fails, rethrows the error.
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

  /// Inserts a new Todo to the database and returns true if the operation is
  /// successful or false if the operation fails.
  ///
  /// Creates a new [Todo] with the given [todoName], the current time as both
  /// [createdOn] and [updatedOn], and [isDone] set to false.
  ///
  /// Calls [DatabaseQuery.createTodo] to insert the new Todo to the database.
  ///
  /// If the operation fails, rethrows the error.
  Future<bool> insertTodo(String todoName) async {
    try {
      Todo addTodo = Todo(
          todoName: todoName,
          createdOn: DateTime.now().toIso8601String(),
          updatedOn: DateTime.now().toIso8601String(),
          isDone: 0);
      final resp = await _query.createTodo(addTodo);
      return resp;
    } catch (e) {
      rethrow;
    }
  }

  /// Updates a Todo item in the database and returns true if the operation is
  /// successful or false if the operation fails.
  ///
  /// Calls [DatabaseQuery.updateTodo] to update the Todo in the database.
  ///
  /// If the operation fails, rethrows the error.
  Future<bool> updateTodo(Todo updatedTodo) async {
    try {
      final resp =
          await _query.updateTodo(updatedTodo.todoId!, updatedTodo.toMap());
      return resp;
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a Todo item from the database and returns true if the operation is
  /// successful or false if the operation fails.
  ///
  /// Calls [DatabaseQuery.deleteTodo] to delete the Todo from the database.
  ///
  /// If the operation fails, rethrows the error.
  Future<bool> deleteTodo(int todoId) async {
    try {
      final resp = await _query.deleteTodo(todoId);
      return resp;
    } catch (e) {
      rethrow;
    }
  }
}
