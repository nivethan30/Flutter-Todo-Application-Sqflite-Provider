import '../model/todo.dart';
import 'database_helper.dart';
import 'table_structure.dart';

class DatabaseQuery {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  /// Creates a new Todo item in the database and returns true if the operation
  /// is successful or false if the operation fails.
  ///
  /// Calls [DatabaseHelper.database] to get a handle to the database.
  ///
  /// Calls [database.insert] to insert the Todo into the database.
  ///
  /// If the Todo is inserted successfully, the function returns true.
  ///
  /// If the Todo is not inserted successfully, the function returns false.
  ///
  /// If an error occurs, the function rethrows the error.
  Future<bool> createTodo(Todo todo) async {
    try {
      final db = await _databaseHelper.database;
      final int id = await db.insert(TableNames.todoTable, todo.toMap());
      return id > 0;
    } catch (e) {
      rethrow;
    }
  }

  /// Gets all the todos from the database and returns a list of [Map]s
  /// representing the todos.
  ///
  /// Calls [DatabaseHelper.database] to get a handle to the database.
  ///
  /// Calls [database.query] to get all the todos from the database.
  ///
  /// If the operation is successful, the function returns a list of [Map]s
  /// representing the todos.
  ///
  /// If an error occurs, the function rethrows the error.
  Future<List<Map<String, dynamic>>> getTodos() async {
    try {
      final db = await _databaseHelper.database;
      return await db.query(TableNames.todoTable);
    } catch (e) {
      rethrow;
    }
  }

  /// Updates a Todo item in the database and returns true if the operation is
  /// successful or false if the operation fails.
  ///
  /// Calls [DatabaseHelper.database] to get a handle to the database.
  ///
  /// Calls [database.update] to update the Todo in the database.
  ///
  /// If the operation is successful, the function returns true.
  ///
  /// If the operation fails, the function returns false.
  ///
  /// If an error occurs, the function rethrows the error.
  Future<bool> updateTodo(int id, Map<String, dynamic> todo) async {
    try {
      final db = await _databaseHelper.database;
      final int count = await db.update(TableNames.todoTable, todo,
          where: '${TodoColumns.id}=?', whereArgs: [id]);
      return count > 0;
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a Todo item from the database and returns true if the operation is
  /// successful or false if the operation fails.
  ///
  /// Calls [DatabaseHelper.database] to get a handle to the database.
  ///
  /// Calls [database.delete] to delete the Todo from the database.
  ///
  /// If the operation is successful, the function returns true.
  ///
  /// If the operation fails, the function returns false.
  ///
  /// If an error occurs, the function rethrows the error.
  Future<bool> deleteTodo(int todoId) async {
    try {
      final db = await _databaseHelper.database;
      final id = await db.delete(TableNames.todoTable,
          where: '${TodoColumns.id}=?', whereArgs: [todoId]);
      return id > 0;
    } catch (e) {
      rethrow;
    }
  }
}
