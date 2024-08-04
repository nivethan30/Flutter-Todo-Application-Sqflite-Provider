import 'table_structure.dart';

class TableCreation {
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
