import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_todo.dart';
import '../providers/todo_provider.dart';
import '../model/todo.dart';
import 'add_todo.dart';
import '../providers/theme_provider.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';

class TodoMain extends StatefulWidget {
  const TodoMain({super.key});

  @override
  State<TodoMain> createState() => _TodoMainState();
}

class _TodoMainState extends State<TodoMain> {
  final TextEditingController todoNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).getTodo();
    });
  }

  void popContext() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final todoProvider = Provider.of<TodoProvider>(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Constants.appBarTitle,
            style: themeProvider.themeData == AppTheme.light()
                ? Constants.poppinsNormalLight
                : Constants.poppinsNormalDark,
          ),
          actions: [
            IconButton(
                tooltip: "Change Theme",
                onPressed: () {
                  themeProvider.toggleTheme();
                },
                icon: themeProvider.themeData == AppTheme.light()
                    ? const Icon(
                        Icons.brightness_4,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.brightness_7,
                        color: Colors.white,
                      )),
            const SizedBox(width: 20),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              List<Todo> reversedTodo = todoProvider.todos.reversed.toList();
              Todo todo = reversedTodo[index];
              return Card(
                child: ListTile(
                  onTap: () {
                    EditTodo().show(
                        todoName: todo.todoName.toString(),
                        context: context,
                        themeProvider: themeProvider,
                        onEditPressed: (val) {
                          editTodo(todoProvider, todo, val);
                        });
                  },
                  tileColor: themeProvider.themeData == AppTheme.light()
                      ? Colors.grey.shade300
                      : Colors.deepPurple.shade800,
                  title: Text(
                    todo.todoName.toString(),
                    style: themeProvider.themeData == AppTheme.light()
                        ? Constants.poppinsNormalLight
                        : Constants.poppinsNormalDark,
                  ),
                  leading: Checkbox(
                      checkColor: Colors.white,
                      value: todo.isDone == 0 ? false : true,
                      onChanged: (bool? val) {
                        changeTodoStatus(todoProvider, todo);
                      }),
                  trailing: IconButton(
                    onPressed: () {
                      deleteTodo(todoProvider, todo.todoId.toString());
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "New Todo",
          onPressed: () {
            AddTodo().show(
                context: context,
                themeProvider: themeProvider,
                onAddPressed: (val) {
                  addTodo(todoProvider, val);
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> addTodo(TodoProvider todoProvider, String val) async {
    try {
      if (val != "") {
        todoProvider.todoNameController.text = val;
        final resp = await todoProvider.insertTodo();
        if (resp) {
          todoProvider.todoNameController.clear();
          todoProvider.getTodo();
        } else {}
        popContext();
      } else {
        popContext();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> changeTodoStatus(TodoProvider todoProvider, Todo todo) async {
    try {
      todoProvider.isDone = !todoProvider.isDone;
      todoProvider.todoIdController.text = todo.todoId.toString();
      todoProvider.todoNameController.text = todo.todoName.toString();
      final resp = await todoProvider.updateTodo();
      if (resp) {
        todoProvider.getTodo();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTodo(TodoProvider todoProvider, String todoId) async {
    try {
      final resp = await todoProvider.deleteTodo(int.parse(todoId));
      if (resp) {
        todoProvider.getTodo();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> editTodo(
      TodoProvider todoProvider, Todo todo, String val) async {
    try {
      if (val != "") {
        todoProvider.isDone = (todo.isDone == 0) ? false : true;
        todoProvider.todoNameController.text = val;
        todoProvider.todoIdController.text = todo.todoId.toString();
        final resp = await todoProvider.updateTodo();
        if (resp) {
          todoProvider.todoNameController.clear();
          todoProvider.todoIdController.clear();
          todoProvider.isDone = false;
          await todoProvider.getTodo();
        } else {}
        popContext();
      } else {
        popContext();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
