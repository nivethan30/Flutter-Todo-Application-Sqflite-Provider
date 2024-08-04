import 'dart:convert';
import '../database/table_structure.dart';

class Todo {
  int? todoId;
  String? todoName;
  int? isDone;
  String? createdOn;
  String? updatedOn;

  Todo({
    this.todoId,
    this.todoName,
    this.isDone,
    this.createdOn,
    this.updatedOn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TodoColumns.id: todoId,
      TodoColumns.todoName: todoName,
      TodoColumns.isDone: isDone,
      TodoColumns.createdOn: createdOn,
      TodoColumns.updatedOn: updatedOn,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      todoId: map[TodoColumns.id] as int,
      todoName: map[TodoColumns.todoName] as String,
      isDone: map[TodoColumns.isDone] as int,
      createdOn: map[TodoColumns.createdOn] as String,
      updatedOn: map[TodoColumns.updatedOn] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
