import 'package:flutter/material.dart';
import '../../add_edit_todo.dart';
import '../../../model/todo.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/theme.dart';

class TileWidget extends StatelessWidget {
  final ThemeProvider themeProvider;
  final Todo todo;
  final VoidCallback changeTodoStatus;
  final VoidCallback deleteTodo;
  final Function(String value) editTodo;
  const TileWidget(
      {super.key,
      required this.themeProvider,
      required this.todo,
      required this.changeTodoStatus,
      required this.deleteTodo,
      required this.editTodo});

  @override
  /// Builds a [GestureDetector] widget that shows a bottom sheet to edit the
  /// Todo item when tapped. The Todo item is displayed in a [Row] widget with
  /// a [CircleAvatar] that shows the status of the Todo (unchecked or checked),
  /// the name of the Todo, and an [IconButton] to delete the Todo.
  ///
  /// The [CircleAvatar] is used to toggle the status of the Todo when tapped.
  ///
  /// The [IconButton] is used to delete the Todo when pressed.
  ///
  /// The [Container] is used to display the background color of the Todo item.
  /// The background color is determined by the current theme of the app.
  ///
  /// Returns a [Widget] that represents the Todo item.
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AddEditTodo.show(
            context: context,
            todoName: todo.todoName,
            isEdit: true,
            themeProvider: themeProvider,
            onDonePressed: (value) {
              editTodo(value);
            });
      },
      child: Container(
        height: 70,
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: themeProvider.themeData == AppTheme.light()
                ? Colors.grey.shade300
                : Colors.deepPurple.shade800),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: changeTodoStatus,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: todo.isDone == 0
                        ? Icon(
                            Icons.check_box_outline_blank_rounded,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.check_box_outlined,
                            color: Colors.black,
                          )),
              ),
            ),
            Text(
              todo.todoName.toString(),
              style: themeProvider.themeData == AppTheme.light()
                  ? Constants.poppinsNormalLight.copyWith(fontSize: 15)
                  : Constants.poppinsNormalDark.copyWith(fontSize: 15),
            ),
            Expanded(child: SizedBox()),
            IconButton(onPressed: deleteTodo, icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
