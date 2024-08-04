import '../model/todo.dart';
import 'database_helper.dart';
import 'table_structure.dart';

class DatabaseQuery {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<bool> createTodo(Todo todo) async {
    try {
      final db = await _databaseHelper.database;
      final int id = await db.insert(TableNames.todoTable, todo.toMap());
      return id > 0;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    try {
      final db = await _databaseHelper.database;
      return await db.query(TableNames.todoTable);
    } catch (e) {
      rethrow;
    }
  }

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
