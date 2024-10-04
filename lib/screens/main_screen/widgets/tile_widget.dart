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



  /// Builds a single tile of the todo list.
  ///
  /// The [GestureDetector] is used to make the tile clickable. When the tile is
  /// tapped, a bottom sheet is shown to edit the todo.
  ///
  /// The [Container] is used to create a rectangular shape with a rounded
  /// corner. The color of the container is either light grey or dark purple
  /// depending on the current theme of the app.
  ///
  /// The [Row] is used to align the [CircleAvatar], [Text], and [IconButton]
  /// horizontally.
  ///
  /// The [CircleAvatar] is used to display the checkbox icon. The color of the
  /// icon is black. The icon is either an outline or filled checkbox depending on
  /// the [isDone] property of the [Todo] object.
  ///
  /// The [Text] is used to display the name of the todo. The style of the text
  /// depends on the current theme of the app. The text is ellipsized and
  /// truncated to one line.
  ///
  /// The [IconButton] is used to delete the todo. The icon of the button is a
  /// delete icon. When the button is pressed, the [deleteTodo] callback is called.
  
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
            Expanded(
              flex: 5,
              child: Text(
                todo.todoName.toString(),
                style: themeProvider.themeData == AppTheme.light()
                    ? Constants.poppinsNormalLight.copyWith(fontSize: 15)
                    : Constants.poppinsNormalDark.copyWith(fontSize: 15),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(flex: 1, child: SizedBox()),
            IconButton(onPressed: deleteTodo, icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
