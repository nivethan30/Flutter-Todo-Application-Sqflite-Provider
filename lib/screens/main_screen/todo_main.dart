import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/todo_provider.dart';
import '../../model/todo.dart';
import '../add_edit_todo.dart';
import '../../providers/theme_provider.dart';
import 'widgets/app_bar.dart';
import 'widgets/tile_widget.dart';

class TodoMain extends StatefulWidget {
  const TodoMain({super.key});

  @override
  State<TodoMain> createState() => _TodoMainState();
}

class _TodoMainState extends State<TodoMain> {
  final TextEditingController todoNameController = TextEditingController();

  @override
  ///
  /// Loads the list of todos when the widget is first created.
  ///
  /// This is called when the widget is inserted into the tree.
  ///
  /// The list of todos is loaded by calling the [TodoProvider.getTodo] method.
  ///
  /// This needs to be called in [initState] because [TodoProvider.getTodo] is
  /// an asynchronous method. The [WidgetsBinding.instance.addPostFrameCallback] is used
  /// to ensure that the list of todos is loaded after the widget has been
  /// inserted into the tree.
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).getTodo();
    });
  }

  /// Pops the current context from the navigator that most tightly encloses the
  /// given [context].
  ///
  /// This is used to dismiss the bottom sheet when the done button is pressed.
  ///
  /// Returns a [Future] that resolves when the pop transition is complete.
  ///
  void popContext() {
    Navigator.pop(context);
  }

  @override
  /// Builds the main screen of the app.
  ///
  /// The [ThemeProvider] is used to get the current theme of the app.
  ///
  /// The [TodoProvider] is used to get the list of todos.
  ///
  /// The list of todos is displayed in a [ListView] with a [TileWidget] for each
  /// todo item.
  ///
  /// The [FloatingActionButton] is used to add a new todo. When pressed, it shows
  /// a bottom sheet to add a new todo.
  ///
  /// The [Scaffold] is used to display the app bar and the body of the screen.
  ///
  /// The [SafeArea] is used to ensure that the content is displayed within the
  /// safe area of the screen.
  ///
  /// Returns a [Widget] that represents the main screen of the app.
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final todoProvider = Provider.of<TodoProvider>(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarWidget(
          themeProvider: themeProvider,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              List<Todo> reversedTodo = todoProvider.todos.reversed.toList();
              Todo todo = reversedTodo[index];
              return TileWidget(
                themeProvider: themeProvider,
                todo: todo,
                changeTodoStatus: () {
                  changeTodoStatus(todoProvider, todo);
                },
                deleteTodo: () {
                  deleteTodo(todoProvider, todo.todoId!);
                },
                editTodo: (value) {
                  editTodo(todoProvider, todo, value);
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "New Todo",
          onPressed: () {
            AddEditTodo.show(
                context: context,
                todoName: null,
                isEdit: false,
                themeProvider: themeProvider,
                onDonePressed: (val) {
                  addTodo(todoProvider, val);
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  /// Adds a new Todo to the list of Todos.
  ///
  /// Calls [TodoProvider.insertTodo] to add the Todo to the database.
  ///
  /// If the Todo is added successfully, calls [TodoProvider.getTodo] to
  /// refresh the list of Todos.
  ///
  /// If the Todo is not added successfully, does nothing.
  ///
  /// When the operation is complete, pops the current context from the
  /// navigator.
  ///
  /// [val] is the name of the Todo to be added.
  Future<void> addTodo(TodoProvider todoProvider, String val) async {
    try {
      if (val.isNotEmpty) {
        final resp = await todoProvider.insertTodo(val);
        if (resp) {
          todoProvider.getTodo();
        } else {}
        popContext();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Changes the status of a Todo item to done or not done.
  ///
  /// Calls [TodoProvider.updateTodo] to update the Todo in the database.
  ///
  /// If the Todo is updated successfully, calls [TodoProvider.getTodo] to
  /// refresh the list of Todos.
  ///
  /// If the Todo is not updated successfully, does nothing.
  ///
  /// When the operation is complete, pops the current context from the
  /// navigator.
  ///
  /// [todoProvider] is the [TodoProvider] instance.
  ///
  /// [todo] is the Todo item to be updated.
  Future<void> changeTodoStatus(TodoProvider todoProvider, Todo todo) async {
    try {
      Todo updatedTodo = todo.copyWith(isDone: todo.isDone == 0 ? 1 : 0);
      final resp = await todoProvider.updateTodo(updatedTodo);
      if (resp) {
        todoProvider.getTodo();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Deletes a Todo item from the database.
  ///
  /// Calls [TodoProvider.deleteTodo] to delete the Todo from the database.
  ///
  /// If the Todo is deleted successfully, calls [TodoProvider.getTodo] to
  /// refresh the list of Todos.
  ///
  /// If the Todo is not deleted successfully, does nothing.
  ///
  /// When the operation is complete, does nothing.
  ///
  /// [todoProvider] is the [TodoProvider] instance.
  ///
  /// [todoId] is the id of the Todo item to be deleted.
  Future<void> deleteTodo(TodoProvider todoProvider, int todoId) async {
    try {
      final resp = await todoProvider.deleteTodo(todoId);
      if (resp) {
        todoProvider.getTodo();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Edits a Todo item in the database.
  ///
  /// Calls [TodoProvider.updateTodo] to update the Todo in the database.
  ///
  /// If the Todo is updated successfully, calls [TodoProvider.getTodo] to
  /// refresh the list of Todos.
  ///
  /// If the Todo is not updated successfully, does nothing.
  ///
  /// When the operation is complete, pops the current context from the
  /// navigator.
  ///
  /// [todoProvider] is the [TodoProvider] instance.
  ///
  /// [todo] is the Todo item to be edited.
  ///
  /// [val] is the new name of the Todo item. If empty, the Todo will not be
  /// updated.
  Future<void> editTodo(
      TodoProvider todoProvider, Todo todo, String val) async {
    try {
      if (val.isNotEmpty) {
        Todo updatedTodo = todo.copyWith(todoName: val);
        final resp = await todoProvider.updateTodo(updatedTodo);
        if (resp) {
          await todoProvider.getTodo();
        } else {}
        popContext();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
