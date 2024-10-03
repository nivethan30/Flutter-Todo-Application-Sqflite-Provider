import 'table_structure.dart';

class TableCreation {
  /// This function is called when the database is first created.
  ///
  /// This function creates the [TableNames.todoTable] table in the database.
  /// The table has the following columns:
  ///
  /// - ${TodoColumns.id}: The primary key of the table, an auto-incrementing
  ///   integer.
  /// - ${TodoColumns.todoName}: The name of the todo, a text string.
  /// - ${TodoColumns.isDone}: Whether the todo is done or not, a boolean.
  /// - ${TodoColumns.createdOn}: The timestamp when the todo was created, a
  ///   timestamp.
  /// - ${TodoColumns.updatedOn}: The timestamp when the todo was last updated, a
  ///   timestamp.
  static Future<void> onCreate(db, version) async {
    await db.execute('''
      CREATE TABLE ${TableNames.todoTable}(
        ${TodoColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TodoColumns.todoName} TEXT NOT NULL,
        ${TodoColumns.isDone} NOT NULL,
        ${TodoColumns.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        ${TodoColumns.updatedOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      ''');
  }
}
